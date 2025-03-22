import 'package:flutter/material.dart';
import 'package:routined/core/common/colors.dart';

import '../../core/common/app_test_style.dart';
import 'circle_day.dart';

class AddAlarm extends StatefulWidget {
  static const String routeName = "/add-alarm";
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  late TimeOfDay _selectedTime;
  late ValueChanged<TimeOfDay> selectTime;

  @override
  void initState() {
    _selectedTime = const TimeOfDay(hour: 12, minute: 30);

    super.initState();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    setState(() {
      _selectedTime = picked!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        title: const Column(
          children: [
            Icon(Icons.alarm_add, color: Color(0xff1b2c57)),
            Text(
              'addAlarm',
              style: TextStyle(color: kCaptionColor, fontSize: 25),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              child: AppTextStyle.headingBoldText(
                _selectedTime.format(context),
              ),
              onTap: () {
                _selectTime(context);
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleDay('Sun', context, false),
                circleDay('Mon', context, true),
                circleDay('Tue', context, true),
                circleDay('Wed', context, true),
                circleDay('Thu', context, true),
                circleDay('Fri', context, true),
                circleDay('Sat', context, false),
              ],
            ),
            const SizedBox(height: 60),
            Container(height: 2, color: Colors.black),
            ListTile(
                leading:
                    const Icon(Icons.notifications_none, color: kCaptionColor),
                title: AppTextStyle.smallText('Alarm Notification')),
            const SizedBox(height: 60),
            Container(height: 2, color: Colors.black),
            ListTile(
                leading: const Icon(Icons.check_box, color: kCaptionColor),
                title: AppTextStyle.smallText('Vibrate')),
            const SizedBox(height: 60),
            Container(height: 2, color: Colors.black),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: AppTextStyle.smallBoldText('Save')),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
