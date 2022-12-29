import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routined/core/common/globals.dart';
import '../../core/widgets/custom_appbar.dart';
import '../widgets/habbit_tile.dart';

class HabbitTrackerPage extends StatefulWidget {
  const HabbitTrackerPage({super.key});

  @override
  State<HabbitTrackerPage> createState() => _HabbitTrackerPageState();
}

class _HabbitTrackerPageState extends State<HabbitTrackerPage> {
  List habbitList = [
    ['Excercise', false, 60, 30],
    ['Extortion', false, 80, 30],
    ['Exibition', false, 50, 30],
    ['Exfactor', false, 180, 30],
  ];

  void habbitStarted(int index) {
    /// Grab the start time
    DateTime startTime = DateTime.now();

    /// Keep track of the previous time
    int elapsedTime = habbitList[index][3];
    setState(() {
      habbitList[index][1] = !habbitList[index][1];
    });

    ///keep the timer going
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ///check if user has stoopped the timer
      setState(() {
        if (habbitList[index][1] == false) {
          timer.cancel();
        }
        var currentTime = DateTime.now();
        habbitList[index][3] = elapsedTime +
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
            title: Text('Settings for ${habbitList[index][0]}'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(titleText: 'Habbit tracker', appBarColor: Colors.grey, key: Globals.drawerKey),
      body: ListView.builder(
        itemCount: habbitList.length,
        itemBuilder: (ctx, index) => HabbitTile(
          habbitName: habbitList[index][0],
          habbitStarted: habbitList[index][1],
          ontap: () => habbitStarted(index),
          settingsOntap: () => settingsOpened(index),
          timeGoal: habbitList[index][2],
          timeSpent: habbitList[index][3],
        ),
      ),
    );
  }
}
