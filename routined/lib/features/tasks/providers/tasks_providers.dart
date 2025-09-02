import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/tasks_notifier.dart';

import '../../../data/models/tasks.dart';

final tasksProvider =
    AutoDisposeAsyncNotifierProvider<TasksNotifier, List<Task>>(
      TasksNotifier.new,
    );
