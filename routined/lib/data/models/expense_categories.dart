import 'package:drift/drift.dart';

class ExpenseCategory {
  final int id;
  final String name;
  final int color;
  final bool isDefault;

  ExpenseCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.isDefault,
  });

  //copy with
  ExpenseCategory copyWith({
    int? id,
    String? name,
    int? color,
    bool? isDefault,
  }) {
    return ExpenseCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

@UseRowClass(ExpenseCategory)
class ExpenseCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  // ARGB color value as int
  IntColumn get color => integer().withDefault(const Constant(0xff9e9e9e))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}
