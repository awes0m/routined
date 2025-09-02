import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/alarms.dart';

import '../view_model/reminders_notifier.dart';

final remindersProvider =
    AutoDisposeAsyncNotifierProvider<RemindersNotifier, List<Alarm>>(
      RemindersNotifier.new,
    );
