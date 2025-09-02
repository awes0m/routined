import 'package:drift/drift.dart';

class Note {
  final int id;
  final String title;
  final String content;
  final int color; // ARGB
  final bool pinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.pinned,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? color,
    bool? pinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    color: color ?? this.color,
    pinned: pinned ?? this.pinned,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}

@UseRowClass(Note)
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>
      text().withLength(min: 0, max: 200).withDefault(const Constant(''))();
  TextColumn get content => text()();
  IntColumn get color => integer().withDefault(const Constant(0xFFFFFFFF))();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
