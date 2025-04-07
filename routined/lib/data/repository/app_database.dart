import 'package:drift/drift.dart';
import '../models/habbits.dart';
import '../models/tasks.dart';
import 'database_connection.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Habbits, Tasks])
class AppDatabase extends _$AppDatabase {
  // List to store habits
  List<Habbit> habbitList = [];

  static AppDatabase instance() => AppDatabase();

  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // Create initial data for the database
  Future<void> createInitialData() async {
    // Initialize with empty list
    habbitList = [];
    // Save the empty list to database
    await updateData();
  }

  // Load data from the database
  Future<void> loadData() async {
    // Query all habits from the database
    final habits = await select(habbits).get();
    habbitList = habits;
  }

  // Update data in the database
  Future<void> updateData() async {
    // Clear existing data
    await delete(habbits).go();

    // Insert all habits from the list
    for (var habit in habbitList) {
      await into(habbits).insert(
        HabbitsCompanion.insert(
          habbitName: habit.habbitName,
          timeSpent: Value(habit.timeSpent),
          timeGoal: Value(habit.timeGoal),
          habbitStarted: Value(habit.habbitStarted),
          createdAt: Value(habit.createdAt),
        ),
      );
    }
  }
}
