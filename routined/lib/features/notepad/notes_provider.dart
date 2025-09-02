import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode;

import '../../data/repository/app_database.dart';
import '../../data/models/notes.dart';

final notesProvider =
    AutoDisposeAsyncNotifierProvider<NotesNotifier, List<Note>>(
      NotesNotifier.new,
    );

class NotesNotifier extends AutoDisposeAsyncNotifier<List<Note>> {
  late final AppDatabase _db;

  @override
  Future<List<Note>> build() async {
    _db = AppDatabase.instance();
    final q = _db.select(_db.notes)..orderBy([
      (n) => OrderingTerm(expression: n.pinned, mode: OrderingMode.desc),
      (n) => OrderingTerm(expression: n.updatedAt, mode: OrderingMode.desc),
    ]);
    return q.get();
  }

  Future<void> add({
    required String content,
    String title = '',
    int color = 0xFFFFFFFF,
    bool pinned = false,
  }) async {
    // Use insert() to get the row id (works on all SQLite versions),
    // then fetch the inserted row to respect DB defaults (createdAt/updatedAt).
    final insertedId = await _db
        .into(_db.notes)
        .insert(
          NotesCompanion.insert(content: content.trim()).copyWith(
            title: Value(title.trim()),
            color: Value(color),
            pinned: Value(pinned),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );

    final inserted =
        await (_db.select(_db.notes)
          ..where((t) => t.id.equals(insertedId))).getSingle();

    final current = state.value ?? const <Note>[];
    state = AsyncData([inserted, ...current]);
  }

  Future<void> updateNote(
    Note note, {
    String? title,
    String? content,
    int? color,
    bool? pinned,
  }) async {
    // Write only changed fields + bump updatedAt in DB
    await (_db.update(_db.notes)..where((t) => t.id.equals(note.id))).write(
      NotesCompanion(
        title: title != null ? Value(title.trim()) : const Value.absent(),
        content: content != null ? Value(content.trim()) : const Value.absent(),
        color: color != null ? Value(color) : const Value.absent(),
        pinned: pinned != null ? Value(pinned) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    // Update local state
    final updated = note.copyWith(
      title: title?.trim(),
      content: content?.trim(),
      color: color,
      pinned: pinned,
      updatedAt: DateTime.now(),
    );

    final list = [...(state.value ?? const <Note>[])];
    final idx = list.indexWhere((n) => n.id == note.id);
    if (idx != -1) {
      list[idx] = updated;
      // Re-sort by pinned, updatedAt desc
      list.sort((a, b) {
        if (a.pinned != b.pinned) return b.pinned ? 1 : -1;
        return b.updatedAt.compareTo(a.updatedAt);
      });
      state = AsyncData(list);
    }
  }

  Future<void> togglePin(Note note) async {
    await updateNote(note, pinned: !note.pinned);
  }

  Future<void> remove(int id) async {
    await _db.delete(_db.notes).delete(NotesCompanion(id: Value(id)));
    final current = state.value ?? const <Note>[];
    state = AsyncData(current.where((n) => n.id != id).toList());
  }
}
