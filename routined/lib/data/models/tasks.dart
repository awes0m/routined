import 'package:drift/drift.dart';
import 'package:routined/data/repository/app_database.dart';

@UseRowClass(Task)
class Tasks extends Table {
  IntColumn get id => integer().withDefault(Constant(0)).autoIncrement()();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get description => text().nullable().named('description')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
