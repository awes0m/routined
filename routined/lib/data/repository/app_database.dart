import 'package:drift/drift.dart';
import '../models/habbits.dart';
import '../models/tasks.dart';
import '../models/alarms.dart';
import '../models/accounts.dart';
import '../models/expense_categories.dart';
import '../models/transactions.dart';
import '../models/notes.dart';
import 'database_connection.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Habbits,
    Tasks,
    Alarms,
    Accounts,
    ExpenseCategories,
    Transactions,
    Notes,
  ],
)
class AppDatabase extends _$AppDatabase {
  // List to store habits
  List<Habbit> habbitList = [];
  List<Note> noteList = [];

  // Singleton instance for a single DB connection across the app
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase.instance() => _instance;

  AppDatabase._internal() : super(openConnection());

  @override
  int get schemaVersion => 3;

  // Handle create/upgrade and seed defaults
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Seed default expense categories and a default account
      final defaults = <ExpenseCategoriesCompanion>[
        ExpenseCategoriesCompanion.insert(
          name: 'Food',
          color: const Value(0xff4caf50),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Travel',
          color: const Value(0xff2196f3),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Bills',
          color: const Value(0xff9c27b0),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Shopping',
          color: const Value(0xffff9800),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Health',
          color: const Value(0xffe91e63),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Entertainment',
          color: const Value(0xff795548),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Rent',
          color: const Value(0xff607d8b),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Utilities',
          color: const Value(0xff3f51b5),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Education',
          color: const Value(0xff009688),
          isDefault: const Value(true),
        ),
        ExpenseCategoriesCompanion.insert(
          name: 'Other',
          color: const Value(0xff9e9e9e),
          isDefault: const Value(true),
        ),
      ];
      for (final d in defaults) {
        await into(expenseCategories).insert(d);
      }
      await into(accounts).insert(
        AccountsCompanion.insert(
          name: 'Cash',
          balanceCents: const Value(0),
          createdAt: Value(DateTime.now()),
        ),
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(accounts);
        await m.createTable(expenseCategories);
        await m.createTable(transactions);
        // Seed basics on upgrade
        await into(accounts).insert(
          AccountsCompanion.insert(
            name: 'Cash',
            balanceCents: const Value(0),
            createdAt: Value(DateTime.now()),
          ),
        );
        final defaults = <ExpenseCategoriesCompanion>[
          ExpenseCategoriesCompanion.insert(
            name: 'Food',
            color: const Value(0xff4caf50),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Travel',
            color: const Value(0xff2196f3),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Bills',
            color: const Value(0xff9c27b0),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Shopping',
            color: const Value(0xffff9800),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Health',
            color: const Value(0xffe91e63),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Entertainment',
            color: const Value(0xff795548),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Rent',
            color: const Value(0xff607d8b),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Utilities',
            color: const Value(0xff3f51b5),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Education',
            color: const Value(0xff009688),
            isDefault: const Value(true),
          ),
          ExpenseCategoriesCompanion.insert(
            name: 'Other',
            color: const Value(0xff9e9e9e),
            isDefault: const Value(true),
          ),
        ];
        for (final d in defaults) {
          await into(expenseCategories).insert(d);
        }
      }
      if (from < 3) {
        await m.createTable(notes);
      }
    },
  );

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
