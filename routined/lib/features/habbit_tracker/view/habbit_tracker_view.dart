import 'package:flutter/material.dart';
import 'package:routined/features/habbit_tracker/widgets/habbits_dialogbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import '../../../constants/db_constants.dart';
import '../../../common/custom_appbar.dart';
import '../widgets/habbit_tile.dart';
import '../providers/habits_providers.dart';

class HabbitTrackerView extends ConsumerStatefulWidget {
  const HabbitTrackerView({super.key});

  @override
  ConsumerState<HabbitTrackerView> createState() => _HabbitTrackerViewState();
}

class _HabbitTrackerViewState extends ConsumerState<HabbitTrackerView> {
  //text controller
  TextEditingController habbitNameController = TextEditingController();
  TextEditingController hourInputController = TextEditingController();
  TextEditingController minuteInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(habitsProvider.notifier).refresh();
    });
  }

  void habbitStarted(int habitIndex) {
    final habits = ref.read(habitsProvider).value;
    if (habits == null || habitIndex < 0 || habitIndex >= habits.length) return;
    final id = habits[habitIndex].id;
    ref.read(habitsProvider.notifier).toggleStart(id);
  }

  void settingsOpened(int index) {
    final habits = ref.read(habitsProvider).value;
    final name =
        (habits != null && index >= 0 && index < habits.length)
            ? habits[index].habbitName
            : '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text('Settings for $name'));
      },
    );
  }

  // Create new Habbit- Floating action button tapped
  void createNewHabbit() {
    _openCreateDialog();
  }

  void _openCreateDialog() {
    showDialog(
      context: context,
      builder:
          (context) => HabbitDialogBox(
            habbitName: habbitNameController,
            onSave: saveNewHabbit,
            onCancel: () => Navigator.of(context).pop(),
            hourPicker: hourInputController,
            minutePicker: minuteInputController,
            secondsPicker: secondInputController,
          ),
    );
  }

  void deleteHabbit(int index) {
    final habits = ref.read(habitsProvider).value;
    if (habits == null || index < 0 || index >= habits.length) return;
    final id = habits[index].id;
    ref.read(habitsProvider.notifier).deleteHabit(id);
  }

  void saveNewHabbit() {
    String hours =
        hourInputController.text.isEmpty
            ? "00"
            : hourInputController.text.padLeft(2, '0');
    String minutes =
        minuteInputController.text.isEmpty
            ? "00"
            : minuteInputController.text.padLeft(2, '0');
    String seconds =
        secondInputController.text.isEmpty
            ? "00"
            : secondInputController.text.padLeft(2, '0');
    String formattedTimeGoal = "$hours:$minutes:$seconds";

    _saveNewHabit();
  }

  void _saveNewHabit() async {
    String hours =
        hourInputController.text.isEmpty
            ? "00"
            : hourInputController.text.padLeft(2, '0');
    String minutes =
        minuteInputController.text.isEmpty
            ? "00"
            : minuteInputController.text.padLeft(2, '0');
    String seconds =
        secondInputController.text.isEmpty
            ? "00"
            : secondInputController.text.padLeft(2, '0');

    final formatted = "$hours:$minutes:$seconds";
    final timeGoalSeconds = timeToTimeInSecs(formatted);

    try {
      await ref
          .read(habitsProvider.notifier)
          .addHabit(
            name: habbitNameController.text,
            timeGoalSeconds: timeGoalSeconds,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    habbitNameController.clear();
    hourInputController.clear();
    minuteInputController.clear();
    secondInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitsProvider);

    return Scaffold(
      appBar: customAppBar(
        titleText: 'Habbit tracker',
        appBarColor: Colors.grey,
        key: Globals.drawerKey,
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('No habits yet. Tap + to add.'));
          }
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (ctx, index) {
              final h = habits[index];
              return Dismissible(
                key: ValueKey('habit_${h.id}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => deleteHabbit(index),
                child: HabbitTile(
                  habbitName: h.habbitName,
                  habbitStarted: h.habbitStarted,
                  ontap: () => habbitStarted(index),
                  settingsOntap: () => settingsOpened(index),
                  timeGoal: h.timeGoal,
                  timeSpent: h.timeSpent,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: kCaptionColor,
        foregroundColor: kPrimaryColor,
        onPressed: _openCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
