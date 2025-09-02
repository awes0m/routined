import 'package:drift/drift.dart';

class Habbit {
  final int id;
  final String habbitName;
  final int timeSpent;
  final int timeGoal;
  final bool habbitStarted;
  final DateTime? createdAt;

  Habbit({
    required this.id,
    required this.habbitName,
    required this.timeSpent,
    required this.timeGoal,
    required this.habbitStarted,
    this.createdAt,
  });


//copy with
Habbit copyWith({
  int? id,
  String? habbitName,
  int? timeSpent,
  int? timeGoal,
  bool? habbitStarted,
  DateTime? createdAt,
}) {
  return Habbit(
    id: id ?? this.id,
    habbitName: habbitName ?? this.habbitName,
    timeSpent: timeSpent ?? this.timeSpent,
    timeGoal: timeGoal ?? this.timeGoal,
    habbitStarted: habbitStarted ?? this.habbitStarted,
    createdAt: createdAt ?? this.createdAt,
  );
}

}
@UseRowClass(Habbit)
class Habbits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get habbitName => text().withLength(min: 6, max: 32)();
  IntColumn get timeSpent => integer().withDefault(Constant(0))();
  IntColumn get timeGoal => integer().withDefault(Constant(0))();
  BoolColumn get habbitStarted => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();

}


// https://r1n1os.medium.com/drift-local-database-for-flutter-part-1-intro-setup-and-migration-09a64d44f6df#:~:text=For%20this%2C%20create%20a%20dart,tables%20when%20you%20use%20the%20.