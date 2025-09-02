import 'package:drift/drift.dart';
import 'expense_categories.dart';
import 'accounts.dart';

enum TxType { expense, income }

class Transaction {
  final int id;
  final TxType type;
  final int amountCents;
  final int categoryId;
  final int accountId;
  final String? description;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.amountCents,
    required this.categoryId,
    required this.accountId,
    this.description,
    required this.timestamp,
  });

  // copy with
  Transaction copyWith({
    int? id,
    TxType? type,
    int? amountCents,
    int? categoryId,
    int? accountId,
    String? description,
    DateTime? timestamp,
  }) {
    return Transaction(
      id: id ?? this.id,
      type: type ?? this.type,
      amountCents: amountCents ?? this.amountCents,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

@UseRowClass(Transaction)
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => intEnum<TxType>()();
  IntColumn get amountCents => integer()();
  IntColumn get categoryId => integer().references(ExpenseCategories, #id)();
  IntColumn get accountId => integer().references(Accounts, #id)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}
