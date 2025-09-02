import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/data/models/habbits.dart';

import '../view_model/habits_notifier.dart';

final habitsProvider =
    AutoDisposeAsyncNotifierProvider<HabitsNotifier, List<Habbit>>(
      HabitsNotifier.new,
    );
