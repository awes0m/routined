import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/custom_appbar.dart';
import '../../core/core.dart';
import '../widgets/add_alarm.dart';
import '../widgets/alarm_item.dart';
import 'providers/reminders_providers.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(remindersProvider.notifier).refresh();
    });
  }

  String _formatTime(int hour, int minute) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat('hh:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final alarmsAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: customAppBar(titleText: 'Alarms', key: Globals.drawerKey),
      body: alarmsAsync.when(
        data: (alarms) {
          if (alarms.isEmpty) {
            return const Center(child: Text('No alarms yet. Tap + to add.'));
          }
          return ListView.builder(
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final a = alarms[index];
              return Dismissible(
                key: ValueKey('alarm_${a.id}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed:
                    (_) =>
                        ref.read(remindersProvider.notifier).deleteAlarm(a.id),
                child: alarmItem(
                  _formatTime(a.hour, a.minute),
                  a.enabled,
                  onToggle:
                      (val) => ref
                          .read(remindersProvider.notifier)
                          .toggleEnabled(a.id),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      backgroundColor: kBackGroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, AddAlarm.routeName);
          if (result is Map) {
            final hour = result['hour'] as int?;
            final minute = result['minute'] as int?;
            if (hour != null && minute != null) {
              final mask = (result['repeatMask'] as int?) ?? 0;
              await ref
                  .read(remindersProvider.notifier)
                  .addAlarm(hour: hour, minute: minute, repeatMask: mask);
            }
          }
        },
        backgroundColor: const Color(0xff65d1ba),
        child: const Icon(Icons.add, size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
