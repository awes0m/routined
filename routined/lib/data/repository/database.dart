import 'package:hive/hive.dart';

import '../models/tasks.dart';

class TodoDatabase {
  List<Task> toDoList = [];

  // reference our Box
  final _taskBox = Hive.box('myBox');

// Run this if this is the first time user opens app
  void createInitialData() {
    toDoList = [
      Task(
          title: 'Call emma',
          description: 'Lorem ipsum dolor sit amet, consectetur'),
      Task(title: 'Workout'),
      Task(title: 'Die', description: "Why Not"),
    ];
  }

  // load data from Database
  void loadData() {
    toDoList = [..._taskBox.get("TODOLIST")];
  }
  // update the database

  void updateData() {
    _taskBox.put("TODOLIST", toDoList);
  }
}
