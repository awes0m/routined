import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    // Timezone
    tz.initializeTimeZones();
    final localName = tz.local.name; // Will be set by package
    tz.setLocalLocation(tz.getLocation(localName));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
      macOS: iosInit,
    );

    await _plugin.initialize(initSettings);

    _initialized = true;
  }

  Future<bool> requestPermissionWithRationale(BuildContext context) async {
    // On Android T+ (13, API 33) we need POST_NOTIFICATIONS runtime permission.
    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      // Newer flutter_local_notifications exposes areNotificationsEnabled + requestNotificationsPermission
      final areEnabled = await androidPlugin?.areNotificationsEnabled() ?? true;
      if (areEnabled) return true;

      final granted =
          await androidPlugin?.requestNotificationsPermission() ?? true;
      if (!granted && context.mounted) {
        await showDialog(
          context: context,
          builder:
              (c) => AlertDialog(
                title: const Text('Allow notifications'),
                content: const Text(
                  'Routined needs permission to show alarms. You can enable notifications in App settings.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(c).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
      return granted;
    }

    // iOS: request permissions via plugin API
    if (Platform.isIOS) {
      final iosGranted = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return iosGranted ?? true;
    }

    if (Platform.isMacOS) {
      final macGranted = await _plugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return macGranted ?? true;
    }

    return true;
  }

  // Schedules a one-shot alarm at the next occurrence of hour:minute local time.
  Future<void> scheduleDailyLike({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    await init();

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'routined_alarms',
      'Alarms',
      channelDescription: 'Alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    const iosDetails = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily at time
    );
  }

  Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  // Schedule weekly on specific weekdays using a bitmask (Sun=0..Sat=6).
  Future<void> scheduleForRepeatMask({
    required int alarmId,
    required int hour,
    required int minute,
    required int repeatMask,
    required String title,
    required String body,
  }) async {
    await init();
    if (repeatMask == 0) {
      await scheduleDailyLike(
        id: alarmId,
        hour: hour,
        minute: minute,
        title: title,
        body: body,
      );
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'routined_alarms',
      'Alarms',
      channelDescription: 'Alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    const iosDetails = DarwinNotificationDetails();

    for (var i = 0; i < 7; i++) {
      final isSet = (repeatMask & (1 << i)) != 0;
      if (!isSet) continue;
      final id = alarmId * 10 + i; // derive unique id per weekday
      final next = _nextInstanceOfWeekday(hour, minute, i);
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        next,
        const NotificationDetails(android: androidDetails, iOS: iosDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfWeekday(int hour, int minute, int maskIndex) {
    // maskIndex: 0=Sun..6=Sat; DateTime weekday: 1=Mon..7=Sun
    final now = tz.TZDateTime.now(tz.local);
    // Convert maskIndex to DateTime weekday
    final targetWeekday =
        maskIndex == 6
            ? DateTime.saturday
            : (maskIndex == 0 ? DateTime.sunday : maskIndex + 1);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    while (scheduled.weekday != targetWeekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  Future<void> cancelAllForAlarm(int alarmId) async {
    await _plugin.cancel(alarmId);
    for (var i = 0; i < 7; i++) {
      await _plugin.cancel(alarmId * 10 + i);
    }
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
