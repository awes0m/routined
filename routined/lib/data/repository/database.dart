import 'package:hive/hive.dart';

import '../models/tasks.dart';

class TodoDatabase {
  List<Task> toDoList = [];

  // reference our Box
  final _taskBox = Hive.box('myBox');

// Run this if this is the first time user opens app
  void createInitialData() {
    toDoList = [
      Task(title: 'buy baby'),
      Task(title: 'buy baby food'),
      Task(title: 'buy baby diapers'),
      Task(title: 'buy baby clothes'),
      Task(title: 'die'),
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
