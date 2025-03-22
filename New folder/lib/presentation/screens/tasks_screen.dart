import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:routined/data/repository/database.dart';

import '../../core/common/colors.dart';
import '../../core/common/globals.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../data/models/tasks.dart';
import '../widgets/tasks_dialogbox.dart';
import '../widgets/tasks_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
//text controller
  TextEditingController controller = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
//reference the hive box
  final _myBox = Hive.box('taskBox');
  TaskDatabase db = TaskDatabase();
  @override
  void initState() {
    // if this the first time opening the app
    if (_myBox.isEmpty) {
      db.createInitialData();
    } else {
      // if data present
      db.loadData();
    }

    super.initState();
  }

// Checkbox Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.taskList[index].isDone = !db.taskList[index].isDone;
    });
    db.updateData();
  }

// Create new Task- Floating action button tapped
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) => TasksDialogBox(
              textController: controller,
              dateInput: dateInput,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop(),
              descriptionController: descriptionController,
            ));
  }

  //Delete Task
  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateData();
  }

  // Save a task
  void saveNewTask() {
    setState(() {
      db.taskList.add(Task(
          title: controller.text,
          description: (descriptionController.text.trim().isNotEmpty)
              ? descriptionController.text
              : ''));

      Navigator.of(context).pop();
    });
    db.updateData();
    controller.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: kCaptionColor,
        foregroundColor: kPrimaryColor,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(
          titleText: 'Tasks and To-Dos',
          key: Globals.drawerKey,
          appBarColor: kBackGroundColor,
          titleTextColor: kPrimaryColor),
      backgroundColor: kBackGroundColor,
      body: ListView(
        children: List.generate(
            db.taskList.length,
            (index) => TasksTile(
                  title: db.taskList[index].title,
                  taskCompleted: db.taskList[index].isDone,
                  onChanged: (value) => checkBoxChanged(value, index),
                  deletefunction: (context) => deleteTask(index),
                  description: db.taskList[index].description,
                )),
      ),
    );
  }
}
