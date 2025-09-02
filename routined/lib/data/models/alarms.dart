import 'package:drift/drift.dart';

class Alarm {
  final int id;
  final int hour;
  final int minute;
  final bool enabled;
  final int repeatMask;
  final DateTime? createdAt;

  Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.enabled,
    required this.repeatMask,
    this.createdAt,
  });

Alarm copyWith({
  int? id,
  int? hour,
  int? minute,
  bool? enabled,
  int? repeatMask,
  DateTime? createdAt,
}) {
  return Alarm(
    id: id ?? this.id,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    enabled: enabled ?? this.enabled,
    repeatMask: repeatMask ?? this.repeatMask,
    createdAt: createdAt ?? this.createdAt,
  );
}
}

@UseRowClass(Alarm)
class Alarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  // Bitmask for repeat days (Sun=1<<0 ... Sat=1<<6), 0 = no repeat/daily off
  IntColumn get repeatMask => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
