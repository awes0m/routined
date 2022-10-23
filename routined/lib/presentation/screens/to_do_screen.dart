import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:routined/data/repository/database.dart';

import '../../core/common/colors.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../data/models/tasks.dart';
import '../widgets/todo_dialogbox.dart';
import '../widgets/todo_tile.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
//text controller
  TextEditingController controller = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
//reference the hive box
  final _myBox = Hive.box('myBox');
  TodoDatabase db = TodoDatabase();
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
      db.toDoList[index].isDone = !db.toDoList[index].isDone;
    });
    db.updateData();
  }

// Create new Task- Floating action button tapped
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) => TodoDialogBox(
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
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  // Save a task
  void saveNewTask() {
    setState(() {
      db.toDoList.add(Task(
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
        backgroundColor: toDoColor,
        foregroundColor: toDoText,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(
          titleText: 'Tasks and To-Dos',
          appBarColor: toDoColor,
          titleTextColor: toDoText),
      backgroundColor: toDoColor,
      body: ListView(
        children: List.generate(
            db.toDoList.length,
            (index) => TodoTile(
                  title: db.toDoList[index].title,
                  taskCompleted: db.toDoList[index].isDone,
                  onChanged: (value) => checkBoxChanged(value, index),
                  deletefunction: (context) => deleteTask(index),
                  description: db.toDoList[index].description,
                )),
      ),
    );
  }
}
