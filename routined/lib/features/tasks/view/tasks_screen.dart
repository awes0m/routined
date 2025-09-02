import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/globals.dart';
import '../../../common/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/tasks_dialogbox.dart';
import '../widgets/tasks_tile.dart';
import '../providers/tasks_providers.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  // controllers
  final TextEditingController controller = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tasksProvider.notifier).refresh();
    });
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder:
          (context) => TasksDialogBox(
            textController: controller,
            dateInput: dateInput,
            onSave: _saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
            descriptionController: descriptionController,
          ),
    );
  }

  void _deleteTask(int index) {
    final tasks = ref.read(tasksProvider).value;
    if (tasks == null || index < 0 || index >= tasks.length) return;
    final id = tasks[index].id;
    ref.read(tasksProvider.notifier).deleteTask(id);
  }

  void _toggleDone(int index) {
    final tasks = ref.read(tasksProvider).value;
    if (tasks == null || index < 0 || index >= tasks.length) return;
    final id = tasks[index].id;
    ref.read(tasksProvider.notifier).toggleDone(id);
  }

  Future<void> _saveNewTask() async {
    try {
      await ref
          .read(tasksProvider.notifier)
          .addTask(
            title: controller.text,
            description: descriptionController.text,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }

    controller.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: kCaptionColor,
        foregroundColor: kPrimaryColor,
        onPressed: _createNewTask,
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(
        titleText: 'Tasks and To-Dos',
        key: Globals.drawerKey,
        appBarColor: kBackGroundColor,
        titleTextColor: kPrimaryColor,
      ),
      backgroundColor: kBackGroundColor,
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks yet. Tap + to add.'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final t = tasks[index];
              return TasksTile(
                title: t.title,
                taskCompleted: t.isDone,
                onChanged: (_) => _toggleDone(index),
                deletefunction: (_) => _deleteTask(index),
                description: t.description ?? '',
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
