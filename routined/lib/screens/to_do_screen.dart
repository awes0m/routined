import 'package:flutter/material.dart';

import '../core/widgets/custom_appbar.dart';
import '../data/models/tasks.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Task> _tasks = [
    Task(title: 'buy baby', date: DateTime.now()),
    Task(title: 'buy baby food', date: DateTime.now()),
    Task(title: 'buy baby diapers', date: DateTime.now()),
    Task(title: 'buy baby clothes', date: DateTime.now()),
    Task(title: 'die', date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar('Tasks and To-Dos'),
      backgroundColor: Colors.white,
      body: ListView(
        children: List.generate(_tasks.length, (index) => _buildTask(index)),
      ),
    );
  }

  _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(_tasks[index].title),
          subtitle: Text(_tasks[index].date.toString()),
          trailing: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
