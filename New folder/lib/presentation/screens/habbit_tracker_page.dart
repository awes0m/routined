import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routined/core/common/globals.dart';
import 'package:routined/data/models/habbits.dart';
import 'package:routined/presentation/widgets/habbits_dialogbox.dart';
import '../../core/common/colors.dart';
import '../../core/constants/db_constants.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../data/repository/database.dart';
import '../widgets/habbit_tile.dart';

class HabbitTrackerPage extends StatefulWidget {
  const HabbitTrackerPage({super.key});

  @override
  State<HabbitTrackerPage> createState() => _HabbitTrackerPageState();
}

class _HabbitTrackerPageState extends State<HabbitTrackerPage> {
  //text controller
  TextEditingController habbitNameController = TextEditingController();
  TextEditingController hourInputController = TextEditingController();
  TextEditingController minuteInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  bool localTicker = false;
  String timeGoal = "00:00:00";
//reference the hive box
  final _myBox = Hive.box(habbitBox);
  HabbitsDatabase db = HabbitsDatabase();
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

  void habbitStarted(int index) {
    localTicker = db.habbitList[index].habbitStarted;

    /// Grab the start time
    DateTime startTime = DateTime.now();

    /// Keep track of the previous time
    int elapsedTime = db.habbitList[index].timeSpent;
    setState(() {
      localTicker = !localTicker;
      db.habbitList[index].habbitStarted = localTicker;
    });

    ///keep the timer going
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ///check if user has stoopped the timer
      setState(() {
        if (localTicker == false) {
          timer.cancel();
        }
        var currentTime = DateTime.now();
        db.habbitList[index].timeSpent = elapsedTime +
            currentTime.second -
            startTime.second +
            60 * (currentTime.minute - startTime.minute) +
            60 * 60 * (currentTime.hour - startTime.hour) +
            60 * 60 * 24 * (currentTime.day - startTime.day);
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
        });
  }

// Checkbox Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.habbitList[index].habbitStarted = !db.habbitList[index].habbitStarted;
    });
    db.updateData();
  }

// Create new Habbit- Floating action button tapped
  void createNewHabbit() {
    showDialog(
        context: context,
        builder: (context) => HabbitDialogBox(
              habbitName: habbitNameController,
              onSave: saveNewHabbit,
              onCancel: () => Navigator.of(context).pop(),
              hourPicker: hourInputController,
              minutePicker: minuteInputController,
              secondsPicker: secondInputController,
            ));
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
    setState(() {
      db.habbitList.add(Habbit(
          habbitName: habbitNameController.text,
          timeGoal: timeToTimeInSecs(timeGoal),
          date: DateTime.now()));

      Navigator.of(context).pop();
    });
    db.updateData();
    habbitNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemCount: db.habbitList.length,
      itemBuilder: (ctx, index) => HabbitTile(
        habbitName: db.habbitList[index].habbitName,
        habbitStarted: localTicker,
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
          key: Globals.drawerKey),
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
