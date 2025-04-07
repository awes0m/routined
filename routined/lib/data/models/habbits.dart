import 'package:drift/drift.dart';

import '../repository/app_database.dart';


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