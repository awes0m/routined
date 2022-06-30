
class Task {
  int? id;
  String title;
  String description;
  bool isDone;
  DateTime date;
  Task({
    this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'date': date.toIso8601String(),
    };
  }

  factory Task.fromJson(int id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
      date: DateTime.parse(json['date'] as String),
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
      date: date ?? this.date,
    );
  }
}
