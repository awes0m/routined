import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routined/core/colors.dart';
import 'package:routined/core/globals.dart';
import 'package:routined/common/custom_appbar.dart';
import 'package:routined/features/widgets/add_alarm.dart';
import 'package:routined/features/widgets/alarm_item.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late String _timeString;

  @override
  void initState() {
    super.initState();

    _timeString = _formatDateTime(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: 'Alarms', key: Globals.drawerKey),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            alarmItem(_timeString, true),
            alarmItem(_timeString, true),
            alarmItem(_timeString, true),
            alarmItem(_timeString, true),
          ],
        ),
      ),
      backgroundColor: kBackGroundColor,
      floatingActionButton: _bottomButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _bottomButtons() {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, AddAlarm.routeName),
      backgroundColor: const Color(0xff65d1ba),
      child: const Icon(Icons.add, size: 20),
    );
  }
}
