import 'package:hive/hive.dart';

import '../../core/constants/db_constants.dart';
import '../models/habbits.dart';
import '../models/tasks.dart';

class TaskDatabase {
  List<Task> taskList = [];

  // reference our Box
  final _taskBox = Hive.box(taskBox);

// Run this if this is the first time user opens app
  void createInitialData() {
    taskList = [
      Task(
          title: 'Call emma',
          description: 'Lorem ipsum dolor sit amet, consectetur'),
      Task(title: 'Workout'),
      Task(title: 'Die', description: "Why Not"),
    ];
  }

  // load data from Database
  void loadData() {
    taskList = [..._taskBox.get("TODOLIST")];
  }
  // update the database

  void updateData() {
    _taskBox.put("TODOLIST", taskList);
  }
}

class HabbitsDatabase {
  List<Habbit> habbitList = [];

  // reference our Box
  final _habbitBox = Hive.box(habbitBox);

// Run this if this is the first time user opens app
  void createInitialData() {
    habbitList = [
      Habbit(
          habbitName: 'Excercise',
          timeSpent: 30,
          timeGoal: 60,
          habbitStarted: false,
          date: DateTime.now()),
      Habbit(
          habbitName: 'Extortion',
          timeSpent: 30,
          timeGoal: 80,
          habbitStarted: false,
          date: DateTime.now()),
      Habbit(
          habbitName: 'Exfactor',
          timeSpent: 30,
          timeGoal: 60,
          habbitStarted: false,
          date: DateTime.now()),
    ];
  }

  // load data from Database
  void loadData() {
    habbitList = [..._habbitBox.get("HABBITLIST")];
  }
  // update the database

  void updateData() {
    _habbitBox.put("HABBITLIST", habbitList);
  }
}
