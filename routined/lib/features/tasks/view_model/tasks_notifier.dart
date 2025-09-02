import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode, Insertable;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/app_database.dart';
import '../../../data/models/tasks.dart';

class TasksNotifier extends AutoDisposeAsyncNotifier<List<Task>> {
  late final AppDatabase _db;

  @override
  Future<List<Task>> build() async {
    _db = AppDatabase.instance();
    return _load();
  }

  Future<List<Task>> _load() async {
    final query = _db.select(_db.tasks)..orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
    ]);
    return query.get();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> addTask({required String title, String? description}) async {
    final trimmed = title.trim();
    if (trimmed.length < 6) {
      throw ArgumentError('Title must be at least 6 characters');
    }

    final inserted = await _db
        .into(_db.tasks)
        .insertReturning(
          TasksCompanion.insert(
            title: trimmed,
            description: Value(
              description?.trim().isNotEmpty == true
                  ? description!.trim()
                  : null,
            ),
            isDone: const Value(false),
            createdAt: Value(DateTime.now()),
          ),
        );

    final current = state.value ?? const <Task>[];
    state = AsyncData([inserted, ...current]);
  }

  Future<void> toggleDone(int id) async {
    final current = state.value;
    if (current == null) return;
    final index = current.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final task = current[index];
    final updated = task.copyWith(isDone: !task.isDone);

    // update local immediately
    final list = [...current]..[index] = updated;
    state = AsyncData(list);

    // persist
    await _db.update(_db.tasks).replace(updated as Insertable<Task>);
  }

  Future<void> deleteTask(int id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
    final current = state.value ?? const <Task>[];
    state = AsyncData(current.where((t) => t.id != id).toList());
  }

  Future<void> editTask({
    required int id,
    required String title,
    String? description,
  }) async {
    final current = state.value;
    if (current == null) return;
    final index = current.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final trimmed = title.trim();
    if (trimmed.length < 6) {
      throw ArgumentError('Title must be at least 6 characters');
    }

    final old = current[index];
    final updated = old.copyWith(
      title: trimmed,
      description:
          Value(
            description?.trim().isNotEmpty == true ? description!.trim() : null,
          ).toString(),
    );

    // local
    final list = [...current]..[index] = updated;
    state = AsyncData(list);

    // persist
    await _db.update(_db.tasks).replace(updated as Insertable<Task>);
  }
}
