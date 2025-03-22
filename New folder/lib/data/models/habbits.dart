import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:routined/core/constants/db_constants.dart';
part 'habbits.g.dart';

@HiveType(typeId: 1)
class Habbit extends HiveObject {
  int? id;

  @HiveField(0)
  String habbitName;

  @HiveField(1)
  int timeSpent;

  @HiveField(2)
  int timeGoal;

  @HiveField(3, defaultValue: false)
  bool habbitStarted;

  @HiveField(4, defaultValue: '')
  DateTime date;

  Habbit({
    this.id,
    this.habbitName = '',
    this.timeSpent = 0,
    this.timeGoal = 0,
    this.habbitStarted = false,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habbitName': habbitName,
      'timeSpent': timeSpent,
      'habbitStarted': habbitStarted,
      'date': dateToString(date),
    };
  }

  factory Habbit.fromJson(int id, Map<String, dynamic> json) {
    return Habbit(
      id: json['id'] as int,
      habbitName: json['habbitName'] as String,
      timeSpent: json['timeSpent'] as int,
      habbitStarted: json['habbitStarted'] as bool,
      date: DateTime.now(),
    );
  }

  Habbit copyWith({
    int? id,
    String? habbitName,
    int? timeSpent,
    bool? habbitStarted,
    String? date,
  }) {
    return Habbit(
      id: id ?? this.id,
      habbitName: habbitName ?? this.habbitName,
      timeSpent: timeSpent ?? this.timeSpent,
      habbitStarted: habbitStarted ?? this.habbitStarted,
      date: stringToDateTime(date) ?? this.date,
    );
  }
}
