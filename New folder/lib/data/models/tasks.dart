import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'tasks.g.dart';

@HiveType(typeId: 2)
class Task {
  int? id;

  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  String description;
  Task({
    this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Task.fromJson(int id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? date,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
