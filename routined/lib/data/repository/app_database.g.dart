// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabbitsTable extends Habbits with TableInfo<$HabbitsTable, Habbit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabbitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _habbitNameMeta =
      const VerificationMeta('habbitName');
  @override
  late final GeneratedColumn<String> habbitName = GeneratedColumn<String>(
      'habbit_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timeSpentMeta =
      const VerificationMeta('timeSpent');
  @override
  late final GeneratedColumn<int> timeSpent = GeneratedColumn<int>(
      'time_spent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _timeGoalMeta =
      const VerificationMeta('timeGoal');
  @override
  late final GeneratedColumn<int> timeGoal = GeneratedColumn<int>(
      'time_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _habbitStartedMeta =
      const VerificationMeta('habbitStarted');
  @override
  late final GeneratedColumn<bool> habbitStarted = GeneratedColumn<bool>(
      'habbit_started', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("habbit_started" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, habbitName, timeSpent, timeGoal, habbitStarted, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habbits';
  @override
  VerificationContext validateIntegrity(Insertable<Habbit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habbit_name')) {
      context.handle(
          _habbitNameMeta,
          habbitName.isAcceptableOrUnknown(
              data['habbit_name']!, _habbitNameMeta));
    } else if (isInserting) {
      context.missing(_habbitNameMeta);
    }
    if (data.containsKey('time_spent')) {
      context.handle(_timeSpentMeta,
          timeSpent.isAcceptableOrUnknown(data['time_spent']!, _timeSpentMeta));
    }
    if (data.containsKey('time_goal')) {
      context.handle(_timeGoalMeta,
          timeGoal.isAcceptableOrUnknown(data['time_goal']!, _timeGoalMeta));
    }
    if (data.containsKey('habbit_started')) {
      context.handle(
          _habbitStartedMeta,
          habbitStarted.isAcceptableOrUnknown(
              data['habbit_started']!, _habbitStartedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habbit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habbit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      habbitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habbit_name'])!,
      timeSpent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_spent'])!,
      timeGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_goal'])!,
      habbitStarted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}habbit_started'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $HabbitsTable createAlias(String alias) {
    return $HabbitsTable(attachedDatabase, alias);
  }
}

class Habbit extends DataClass implements Insertable<Habbit> {
  final int id;
  final String habbitName;
  final int timeSpent;
  final int timeGoal;
  final bool habbitStarted;
  final DateTime? createdAt;
  const Habbit(
      {required this.id,
      required this.habbitName,
      required this.timeSpent,
      required this.timeGoal,
      required this.habbitStarted,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habbit_name'] = Variable<String>(habbitName);
    map['time_spent'] = Variable<int>(timeSpent);
    map['time_goal'] = Variable<int>(timeGoal);
    map['habbit_started'] = Variable<bool>(habbitStarted);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  HabbitsCompanion toCompanion(bool nullToAbsent) {
    return HabbitsCompanion(
      id: Value(id),
      habbitName: Value(habbitName),
      timeSpent: Value(timeSpent),
      timeGoal: Value(timeGoal),
      habbitStarted: Value(habbitStarted),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Habbit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habbit(
      id: serializer.fromJson<int>(json['id']),
      habbitName: serializer.fromJson<String>(json['habbitName']),
      timeSpent: serializer.fromJson<int>(json['timeSpent']),
      timeGoal: serializer.fromJson<int>(json['timeGoal']),
      habbitStarted: serializer.fromJson<bool>(json['habbitStarted']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habbitName': serializer.toJson<String>(habbitName),
      'timeSpent': serializer.toJson<int>(timeSpent),
      'timeGoal': serializer.toJson<int>(timeGoal),
      'habbitStarted': serializer.toJson<bool>(habbitStarted),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  Habbit copyWith(
          {int? id,
          String? habbitName,
          int? timeSpent,
          int? timeGoal,
          bool? habbitStarted,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      Habbit(
        id: id ?? this.id,
        habbitName: habbitName ?? this.habbitName,
        timeSpent: timeSpent ?? this.timeSpent,
        timeGoal: timeGoal ?? this.timeGoal,
        habbitStarted: habbitStarted ?? this.habbitStarted,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  Habbit copyWithCompanion(HabbitsCompanion data) {
    return Habbit(
      id: data.id.present ? data.id.value : this.id,
      habbitName:
          data.habbitName.present ? data.habbitName.value : this.habbitName,
      timeSpent: data.timeSpent.present ? data.timeSpent.value : this.timeSpent,
      timeGoal: data.timeGoal.present ? data.timeGoal.value : this.timeGoal,
      habbitStarted: data.habbitStarted.present
          ? data.habbitStarted.value
          : this.habbitStarted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habbit(')
          ..write('id: $id, ')
          ..write('habbitName: $habbitName, ')
          ..write('timeSpent: $timeSpent, ')
          ..write('timeGoal: $timeGoal, ')
          ..write('habbitStarted: $habbitStarted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, habbitName, timeSpent, timeGoal, habbitStarted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habbit &&
          other.id == this.id &&
          other.habbitName == this.habbitName &&
          other.timeSpent == this.timeSpent &&
          other.timeGoal == this.timeGoal &&
          other.habbitStarted == this.habbitStarted &&
          other.createdAt == this.createdAt);
}

class HabbitsCompanion extends UpdateCompanion<Habbit> {
  final Value<int> id;
  final Value<String> habbitName;
  final Value<int> timeSpent;
  final Value<int> timeGoal;
  final Value<bool> habbitStarted;
  final Value<DateTime?> createdAt;
  const HabbitsCompanion({
    this.id = const Value.absent(),
    this.habbitName = const Value.absent(),
    this.timeSpent = const Value.absent(),
    this.timeGoal = const Value.absent(),
    this.habbitStarted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabbitsCompanion.insert({
    this.id = const Value.absent(),
    required String habbitName,
    this.timeSpent = const Value.absent(),
    this.timeGoal = const Value.absent(),
    this.habbitStarted = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : habbitName = Value(habbitName);
  static Insertable<Habbit> custom({
    Expression<int>? id,
    Expression<String>? habbitName,
    Expression<int>? timeSpent,
    Expression<int>? timeGoal,
    Expression<bool>? habbitStarted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habbitName != null) 'habbit_name': habbitName,
      if (timeSpent != null) 'time_spent': timeSpent,
      if (timeGoal != null) 'time_goal': timeGoal,
      if (habbitStarted != null) 'habbit_started': habbitStarted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabbitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? habbitName,
      Value<int>? timeSpent,
      Value<int>? timeGoal,
      Value<bool>? habbitStarted,
      Value<DateTime?>? createdAt}) {
    return HabbitsCompanion(
      id: id ?? this.id,
      habbitName: habbitName ?? this.habbitName,
      timeSpent: timeSpent ?? this.timeSpent,
      timeGoal: timeGoal ?? this.timeGoal,
      habbitStarted: habbitStarted ?? this.habbitStarted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habbitName.present) {
      map['habbit_name'] = Variable<String>(habbitName.value);
    }
    if (timeSpent.present) {
      map['time_spent'] = Variable<int>(timeSpent.value);
    }
    if (timeGoal.present) {
      map['time_goal'] = Variable<int>(timeGoal.value);
    }
    if (habbitStarted.present) {
      map['habbit_started'] = Variable<bool>(habbitStarted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabbitsCompanion(')
          ..write('id: $id, ')
          ..write('habbitName: $habbitName, ')
          ..write('timeSpent: $timeSpent, ')
          ..write('timeGoal: $timeGoal, ')
          ..write('habbitStarted: $habbitStarted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
      defaultValue: Constant(0));
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, isDone, title, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final bool isDone;
  final String title;
  final String? description;
  final DateTime? createdAt;
  const Task(
      {required this.id,
      required this.isDone,
      required this.title,
      this.description,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_done'] = Variable<bool>(isDone);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      isDone: Value(isDone),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isDone': serializer.toJson<bool>(isDone),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  Task copyWith(
          {int? id,
          bool? isDone,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('isDone: $isDone, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isDone, title, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.isDone == this.isDone &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<bool> isDone;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> createdAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.isDone = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    this.isDone = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<bool>? isDone,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isDone != null) 'is_done': isDone,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isDone,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? createdAt}) {
    return TasksCompanion(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('isDone: $isDone, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabbitsTable habbits = $HabbitsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habbits, tasks];
}

typedef $$HabbitsTableCreateCompanionBuilder = HabbitsCompanion Function({
  Value<int> id,
  required String habbitName,
  Value<int> timeSpent,
  Value<int> timeGoal,
  Value<bool> habbitStarted,
  Value<DateTime?> createdAt,
});
typedef $$HabbitsTableUpdateCompanionBuilder = HabbitsCompanion Function({
  Value<int> id,
  Value<String> habbitName,
  Value<int> timeSpent,
  Value<int> timeGoal,
  Value<bool> habbitStarted,
  Value<DateTime?> createdAt,
});

class $$HabbitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabbitsTable> {
  $$HabbitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habbitName => $composableBuilder(
      column: $table.habbitName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeSpent => $composableBuilder(
      column: $table.timeSpent, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeGoal => $composableBuilder(
      column: $table.timeGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get habbitStarted => $composableBuilder(
      column: $table.habbitStarted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$HabbitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabbitsTable> {
  $$HabbitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habbitName => $composableBuilder(
      column: $table.habbitName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeSpent => $composableBuilder(
      column: $table.timeSpent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeGoal => $composableBuilder(
      column: $table.timeGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get habbitStarted => $composableBuilder(
      column: $table.habbitStarted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$HabbitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabbitsTable> {
  $$HabbitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habbitName => $composableBuilder(
      column: $table.habbitName, builder: (column) => column);

  GeneratedColumn<int> get timeSpent =>
      $composableBuilder(column: $table.timeSpent, builder: (column) => column);

  GeneratedColumn<int> get timeGoal =>
      $composableBuilder(column: $table.timeGoal, builder: (column) => column);

  GeneratedColumn<bool> get habbitStarted => $composableBuilder(
      column: $table.habbitStarted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HabbitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabbitsTable,
    Habbit,
    $$HabbitsTableFilterComposer,
    $$HabbitsTableOrderingComposer,
    $$HabbitsTableAnnotationComposer,
    $$HabbitsTableCreateCompanionBuilder,
    $$HabbitsTableUpdateCompanionBuilder,
    (Habbit, BaseReferences<_$AppDatabase, $HabbitsTable, Habbit>),
    Habbit,
    PrefetchHooks Function()> {
  $$HabbitsTableTableManager(_$AppDatabase db, $HabbitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabbitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabbitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabbitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> habbitName = const Value.absent(),
            Value<int> timeSpent = const Value.absent(),
            Value<int> timeGoal = const Value.absent(),
            Value<bool> habbitStarted = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              HabbitsCompanion(
            id: id,
            habbitName: habbitName,
            timeSpent: timeSpent,
            timeGoal: timeGoal,
            habbitStarted: habbitStarted,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String habbitName,
            Value<int> timeSpent = const Value.absent(),
            Value<int> timeGoal = const Value.absent(),
            Value<bool> habbitStarted = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              HabbitsCompanion.insert(
            id: id,
            habbitName: habbitName,
            timeSpent: timeSpent,
            timeGoal: timeGoal,
            habbitStarted: habbitStarted,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabbitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabbitsTable,
    Habbit,
    $$HabbitsTableFilterComposer,
    $$HabbitsTableOrderingComposer,
    $$HabbitsTableAnnotationComposer,
    $$HabbitsTableCreateCompanionBuilder,
    $$HabbitsTableUpdateCompanionBuilder,
    (Habbit, BaseReferences<_$AppDatabase, $HabbitsTable, Habbit>),
    Habbit,
    PrefetchHooks Function()>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<bool> isDone,
  required String title,
  Value<String?> description,
  Value<DateTime?> createdAt,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<bool> isDone,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> createdAt,
});

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            isDone: isDone,
            title: title,
            description: description,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            isDone: isDone,
            title: title,
            description: description,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabbitsTableTableManager get habbits =>
      $$HabbitsTableTableManager(_db, _db.habbits);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
}
