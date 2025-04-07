import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routined/core/globals.dart';
import 'package:routined/features/habbit_tracker/widgets/habbits_dialogbox.dart';
import '../../../core/colors.dart';
import '../../../constants/db_constants.dart';
import '../../../common/custom_appbar.dart';
import '../../../data/repository/app_database.dart';
import '../widgets/habbit_tile.dart';

class HabbitTrackerView extends StatefulWidget {
  const HabbitTrackerView({super.key});

  @override
  State<HabbitTrackerView> createState() => _HabbitTrackerViewState();
}

class _HabbitTrackerViewState extends State<HabbitTrackerView> {
  //text controller
  TextEditingController habbitNameController = TextEditingController();
  TextEditingController hourInputController = TextEditingController();
  TextEditingController minuteInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  bool localTicker = false;
  String timeGoal = "00:00:00";
  AppDatabase db = AppDatabase.instance();
  @override
  void initState() {
    super.initState();
    // Load data when the view is initialized
    _loadHabbitData();
  }

  Future<void> _loadHabbitData() async {
    // Check if there are any habits already
    await db.loadData();
    if (db.habbitList.isEmpty) {
      // If no habits exist, create initial data
      await db.createInitialData();
    }
    // Update the UI
    setState(() {});
  }

  void habbitStarted(int index) {
    localTicker = db.habbitList[index].habbitStarted;

    /// Grab the start time
    DateTime startTime = DateTime.now();

    /// Keep track of the previous time
    int elapsedTime = db.habbitList[index].timeSpent;
    setState(() {
      localTicker = !localTicker;
      // Create a new Habbit object with updated habbitStarted value
      db.habbitList[index] = db.habbitList[index].copyWith(
        habbitStarted: localTicker,
      );
    });

    ///keep the timer going
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ///check if user has stoopped the timer
      setState(() {
        if (localTicker == false) {
          timer.cancel();
        } else {
          var currentTime = DateTime.now();
          int newTimeSpent =
              elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour) +
              60 * 60 * 24 * (currentTime.day - startTime.day);

          // Create a new Habbit object with updated timeSpent value
          db.habbitList[index] = db.habbitList[index].copyWith(
            timeSpent: newTimeSpent,
          );
        }
      });
    });
  }

  void settingsOpened(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Settings for ${db.habbitList[index].habbitName}'),
        );
      },
    );
  }

  // Checkbox Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      // Create a new Habbit object with toggled habbitStarted value
      db.habbitList[index] = db.habbitList[index].copyWith(
        habbitStarted: !db.habbitList[index].habbitStarted,
      );
    });
    db.updateData();
  }

  // Create new Habbit- Floating action button tapped
  void createNewHabbit() {
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

  //Delete Habbit
  void deleteHabbit(int index) {
    setState(() {
      db.habbitList.removeAt(index);
    });
    db.updateData();
  }

  // Save a Habbit
  void saveNewHabbit() {
    // Get time goal from input controllers
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

    setState(() {
      // Create a new Habbit with default values for id and other required fields
      db.habbitList.add(
        Habbit(
          id: 0, // This will be auto-assigned by the database
          habbitName: habbitNameController.text,
          timeGoal: timeToTimeInSecs(formattedTimeGoal),
          timeSpent: 0,
          habbitStarted: false,
          createdAt: DateTime.now(),
        ),
      );

      Navigator.of(context).pop();
    });
    db.updateData();

    // Clear all input controllers
    habbitNameController.clear();
    hourInputController.clear();
    minuteInputController.clear();
    secondInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemCount: db.habbitList.length,
      itemBuilder:
          (ctx, index) => HabbitTile(
            habbitName: db.habbitList[index].habbitName,
            habbitStarted: db.habbitList[index].habbitStarted,
            ontap: () => habbitStarted(index),
            settingsOntap: () => settingsOpened(index),
            timeGoal: db.habbitList[index].timeGoal,
            timeSpent: db.habbitList[index].timeSpent,
          ),
    );
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Habbit tracker',
        appBarColor: Colors.grey,
        key: Globals.drawerKey,
      ),
      body: listView,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: kCaptionColor,
        foregroundColor: kPrimaryColor,
        onPressed: createNewHabbit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
