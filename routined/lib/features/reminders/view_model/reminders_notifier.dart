import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode, Insertable;

import '../../../data/repository/app_database.dart';
import '../../../data/models/alarms.dart';

import '../../../core/services/notification_service.dart';

class RemindersNotifier extends AutoDisposeAsyncNotifier<List<Alarm>> {
  late final AppDatabase _db;

  @override
  Future<List<Alarm>> build() async {
    _db = AppDatabase.instance();
    return _load();
  }

  Future<List<Alarm>> _load() async {
    final query = _db.select(_db.alarms)..orderBy([
      (a) => OrderingTerm(expression: a.createdAt, mode: OrderingMode.desc),
    ]);
    return query.get();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> addAlarm({
    required int hour,
    required int minute,
    bool enabled = true,
    int repeatMask = 0,
  }) async {
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw ArgumentError('Invalid time');
    }
    final inserted = await _db
        .into(_db.alarms)
        .insertReturning(
          AlarmsCompanion.insert(
            hour: hour,
            minute: minute,
            enabled: Value(enabled),
            repeatMask: Value(repeatMask),
            createdAt: Value(DateTime.now()),
          ),
        );

    // Schedule notification if enabled
    if (enabled) {
      await NotificationService.instance.scheduleForRepeatMask(
        alarmId: inserted.id,
        hour: hour,
        minute: minute,
        repeatMask: repeatMask,
        title: 'Alarm',
        body: 'It\'s time!',
      );
    }

    final current = state.value ?? const <Alarm>[];
    state = AsyncData([inserted, ...current]);
  }

  Future<void> deleteAlarm(int id) async {
    await (_db.delete(_db.alarms)..where((t) => t.id.equals(id))).go();
    // Cancel scheduled notification
    await NotificationService.instance.cancel(id);

    final current = state.value ?? const <Alarm>[];
    state = AsyncData(current.where((a) => a.id != id).toList());
  }

  Future<void> toggleEnabled(int id) async {
    final current = state.value;
    if (current == null) return;
    final index = current.indexWhere((a) => a.id == id);
    if (index == -1) return;
    final alarm = current[index];
    final nowEnabled = !alarm.enabled;
    final updated = alarm.copyWith(enabled: nowEnabled);

    final list = [...current]..[index] = updated;
    state = AsyncData(list);

    await _db.update(_db.alarms).replace(updated as Insertable<Alarm>);

    if (nowEnabled) {
      await NotificationService.instance.scheduleForRepeatMask(
        alarmId: updated.id,
        hour: updated.hour,
        minute: updated.minute,
        repeatMask: updated.repeatMask,
        title: 'Alarm',
        body: 'It\'s time!',
      );
    } else {
      await NotificationService.instance.cancelAllForAlarm(updated.id);
    }
  }

  Future<void> updateRepeatMask(int id, int repeatMask) async {
    final current = state.value;
    if (current == null) return;
    final index = current.indexWhere((a) => a.id == id);
    if (index == -1) return;
    final alarm = current[index];
    final updated = alarm.copyWith(repeatMask: repeatMask);

    final list = [...current]..[index] = updated;
    state = AsyncData(list);

    await _db.update(_db.alarms).replace(updated as Insertable<Alarm>);

    if (updated.enabled) {
      // Reschedule with new mask
      await NotificationService.instance.cancelAllForAlarm(updated.id);
      await NotificationService.instance.scheduleForRepeatMask(
        alarmId: updated.id,
        hour: updated.hour,
        minute: updated.minute,
        repeatMask: updated.repeatMask,
        title: 'Alarm',
        body: 'It\'s time!',
      );
    }
  }
}
