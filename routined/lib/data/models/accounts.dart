import 'package:drift/drift.dart';

class Account {
  final int id;
  final String name;
  final int balanceCents;
  final DateTime? createdAt;

  Account({
    required this.id,
    required this.name,
    required this.balanceCents,
    this.createdAt,
  });

  Account copyWith({
    int? id,
    String? name,
    int? balanceCents,
    DateTime? createdAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balanceCents: balanceCents ?? this.balanceCents,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@UseRowClass(Account)
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  // Store money in smallest unit (cents) to avoid floating point issues
  IntColumn get balanceCents => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
