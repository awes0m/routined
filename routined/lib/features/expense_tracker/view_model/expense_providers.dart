import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode;

import '../../../data/repository/app_database.dart';
import '../../../data/models/transactions.dart' show TxType, Transaction;
import '../../../data/models/accounts.dart' show Account;
import '../../../data/models/expense_categories.dart' show ExpenseCategory;

final accountsProvider =
    AutoDisposeAsyncNotifierProvider<AccountsNotifier, List<Account>>(
      AccountsNotifier.new,
    );

final categoriesProvider =
    AutoDisposeAsyncNotifierProvider<CategoriesNotifier, List<ExpenseCategory>>(
      CategoriesNotifier.new,
    );

final transactionsProvider =
    AutoDisposeAsyncNotifierProvider<TransactionsNotifier, List<Transaction>>(
      TransactionsNotifier.new,
    );

class AccountsNotifier extends AutoDisposeAsyncNotifier<List<Account>> {
  late final AppDatabase _db;

  @override
  Future<List<Account>> build() async {
    _db = AppDatabase.instance();
    return _db.select(_db.accounts).get();
  }

  Future<void> addAccount({required String name, int initialCents = 0}) async {
    final inserted = await _db
        .into(_db.accounts)
        .insertReturning(
          AccountsCompanion.insert(
            name: name.trim(),
            balanceCents: Value(initialCents),
            createdAt: Value(DateTime.now()),
          ),
        );
    final current = state.value ?? const <Account>[];
    state = AsyncData([...current, inserted]);
  }
}

class CategoriesNotifier
    extends AutoDisposeAsyncNotifier<List<ExpenseCategory>> {
  late final AppDatabase _db;

  @override
  Future<List<ExpenseCategory>> build() async {
    _db = AppDatabase.instance();
    return _db.select(_db.expenseCategories).get();
  }

  Future<void> addCategory({
    required String name,
    int color = 0xff9e9e9e,
  }) async {
    final inserted = await _db
        .into(_db.expenseCategories)
        .insertReturning(
          ExpenseCategoriesCompanion.insert(
            name: name.trim(),
            color: Value(color),
            isDefault: const Value(false),
          ),
        );
    final current = state.value ?? const <ExpenseCategory>[];
    state = AsyncData([...current, inserted]);
  }
}

class TransactionsNotifier extends AutoDisposeAsyncNotifier<List<Transaction>> {
  late final AppDatabase _db;

  @override
  Future<List<Transaction>> build() async {
    _db = AppDatabase.instance();
    final q = _db.select(_db.transactions)..orderBy([
      (t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
    ]);
    return q.get();
  }

  Future<void> addTransaction({
    required TxType type,
    required int amountCents,
    required int categoryId,
    required int accountId,
    String? description,
  }) async {
    // Insert tx
    final inserted = await _db
        .into(_db.transactions)
        .insertReturning(
          TransactionsCompanion.insert(
            type: type, // pass enum directly
            amountCents: amountCents,
            categoryId: categoryId,
            accountId: accountId,
            description: Value(
              description?.trim().isNotEmpty == true
                  ? description!.trim()
                  : null,
            ),
          ),
        );

    // Update account balance
    final account =
        await (_db.select(_db.accounts)
          ..where((a) => a.id.equals(accountId))).getSingle();
    final delta = type == TxType.income ? amountCents : -amountCents;
    final newBalance = account.balanceCents + delta;

    // Persist only the changed column to avoid Insertable type issues
    await (_db.update(_db.accounts)..where(
      (a) => a.id.equals(accountId),
    )).write(AccountsCompanion(balanceCents: Value(newBalance)));

    final current = state.value ?? const <Transaction>[];
    state = AsyncData([inserted, ...current]);
  }
}
