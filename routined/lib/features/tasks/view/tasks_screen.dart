import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/globals.dart';
import '../../../common/custom_appbar.dart';
import '../../../data/repository/app_database.dart';
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
  //reference the database
  final db = AppDatabase.instance();
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    // Load tasks from the database
    _loadTasks();
  }

  // Load tasks from database
  Future<void> _loadTasks() async {
    final tasks = await db.select(db.tasks).get();
    setState(() {
      taskList = tasks;
    });
  }

  // Checkbox Tapped
  void checkBoxChanged(bool? value, int index) async {
    final task = taskList[index];
    final updatedTask = Task(
      id: task.id,
      isDone: !task.isDone,
      title: task.title,
      description: task.description,
      createdAt: task.createdAt,
    );

    await db.update(db.tasks).replace(updatedTask);
    _loadTasks();
  }

  // Create new Task- Floating action button tapped
  void createNewTask() {
    showDialog(
      context: context,
      builder:
          (context) => TasksDialogBox(
            textController: controller,
            dateInput: dateInput,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
            descriptionController: descriptionController,
          ),
    );
  }

  //Delete Task
  void deleteTask(int index) async {
    final task = taskList[index];
    await db.delete(db.tasks).delete(task);
    _loadTasks();
  }

  // Save a task
  void saveNewTask() async {
    if (controller.text.length < 6) {
      // Title must be at least 6 characters according to the schema
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title must be at least 6 characters')),
      );
      return;
    }

    final task = Task(
      id: 0, // Will be auto-incremented
      isDone: false,
      title: controller.text,
      description:
          descriptionController.text.trim().isNotEmpty
              ? descriptionController.text
              : null,
      createdAt: DateTime.now(),
    );

    await db.into(db.tasks).insert(task);
    // Check if the widget is still mounted before using context
    if (mounted) {
      Navigator.of(context).pop();
    }
    _loadTasks();
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
        titleTextColor: kPrimaryColor,
      ),
      backgroundColor: kBackGroundColor,
      body: ListView(
        children: List.generate(
          taskList.length,
          (index) => TasksTile(
            title: taskList[index].title,
            taskCompleted: taskList[index].isDone,
            onChanged: (value) => checkBoxChanged(value, index),
            deletefunction: (context) => deleteTask(index),
            description: taskList[index].description ?? '',
          ),
        ),
      ),
    );
  }
}
