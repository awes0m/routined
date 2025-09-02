import 'dart:async';

import 'package:drift/drift.dart' show Value, Insertable;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/data/models/habbits.dart';

import '../../../data/repository/app_database.dart';

class HabitsNotifier extends AutoDisposeAsyncNotifier<List<Habbit>> {
  late final AppDatabase _db;

  // Track running timers per habit id
  final Map<int, Timer> _timers = {};
  final Map<int, _Running> _running = {};

  @override
  Future<List<Habbit>> build() async {
    _db = AppDatabase.instance();
    ref.onDispose(_disposeAll);
    return _load();
  }

  Future<List<Habbit>> _load() async {
    final list = await _db.select(_db.habbits).get();
    return list;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> addHabit({
    required String name,
    required int timeGoalSeconds,
  }) async {
    if (name.trim().length < 6) {
      throw ArgumentError('Habit name must be at least 6 characters');
    }
    if (timeGoalSeconds < 1) {
      throw ArgumentError('Time goal must be greater than 0');
    }

    final inserted = await _db
        .into(_db.habbits)
        .insertReturning(
          HabbitsCompanion.insert(
            habbitName: name.trim(),
            timeGoal: Value(timeGoalSeconds),
            timeSpent: const Value(0),
            habbitStarted: const Value(false),
            createdAt: Value(DateTime.now()),
          ),
        );

    final current = state.value ?? const <Habbit>[];
    state = AsyncData([...current, inserted]);
  }

  Future<void> deleteHabit(int id) async {
    await (_db.delete(_db.habbits)..where((t) => t.id.equals(id))).go();
    _cancelTimer(id);
    final current = state.value ?? const <Habbit>[];
    state = AsyncData(current.where((h) => h.id != id).toList());
  }

  Future<void> toggleStart(int id) async {
    final current = state.value;
    if (current == null) return;
    final index = current.indexWhere((h) => h.id == id);
    if (index == -1) return;

    final habit = current[index];
    final nowStarted = !habit.habbitStarted;

    // Update local state immediately
    final updated = habit.copyWith(habbitStarted: nowStarted);
    final newList = [...current]..[index] = updated;
    state = AsyncData(newList);

    // Persist the started flag
    await _db.update(_db.habbits).replace(updated as Insertable<Habbit>);

    if (nowStarted) {
      // Start timer tracking
      _running[id] = _Running(
        startTime: DateTime.now(),
        baseElapsed: habit.timeSpent,
      );
      _timers[id]?.cancel();
      _timers[id] = Timer.periodic(const Duration(seconds: 1), (_) {
        final r = _running[id];
        if (r == null) return;
        final elapsed = _computeElapsed(r);
        _patchTimeSpentLocal(id, elapsed);
      });
    } else {
      // Stop and persist final elapsed
      final r = _running[id];
      _cancelTimer(id);
      if (r != null) {
        final elapsed = _computeElapsed(r);
        final finalHabit = updated.copyWith(timeSpent: elapsed);
        await _db.update(_db.habbits).replace(finalHabit as Insertable<Habbit>);
        // Ensure local state has final timeSpent
        final list = state.value ?? newList;
        final i = list.indexWhere((h) => h.id == id);
        if (i != -1) {
          final patched = [...list]..[i] = finalHabit;
          state = AsyncData(patched);
        }
      }
    }
  }

  void _patchTimeSpentLocal(int id, int newTimeSpent) {
    final list = state.value;
    if (list == null) return;
    final i = list.indexWhere((h) => h.id == id);
    if (i == -1) return;
    final patched = list[i].copyWith(timeSpent: newTimeSpent);
    final newList = [...list]..[i] = patched;
    state = AsyncData(newList);
  }

  int _computeElapsed(_Running r) {
    final now = DateTime.now();
    final delta = now.difference(r.startTime).inSeconds;
    return r.baseElapsed + (delta < 0 ? 0 : delta);
  }

  void _cancelTimer(int id) {
    _timers[id]?.cancel();
    _timers.remove(id);
    _running.remove(id);
  }

  void _disposeAll() {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
    _running.clear();
  }
}

class _Running {
  final DateTime startTime;
  final int baseElapsed;
  _Running({required this.startTime, required this.baseElapsed});
}
