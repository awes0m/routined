import 'package:flutter/material.dart';
import 'package:routined/core/colors.dart';

import '../../core/app_test_style.dart';
import 'circle_day.dart';

class AddAlarm extends StatefulWidget {
  static const String routeName = "/add-alarm";
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  late TimeOfDay _selectedTime;
  int _repeatMask = 0; // Sun=1<<0 .. Sat=1<<6

  void _toggleDay(int index) {
    setState(() {
      _repeatMask ^= (1 << index);
    });
  }

  bool _isDayOn(int index) => (_repeatMask & (1 << index)) != 0;

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
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
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
            ),
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
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _toggleDay(0),
                  child: circleDay('Sun', context, _isDayOn(0)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(1),
                  child: circleDay('Mon', context, _isDayOn(1)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(2),
                  child: circleDay('Tue', context, _isDayOn(2)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(3),
                  child: circleDay('Wed', context, _isDayOn(3)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(4),
                  child: circleDay('Thu', context, _isDayOn(4)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(5),
                  child: circleDay('Fri', context, _isDayOn(5)),
                ),
                GestureDetector(
                  onTap: () => _toggleDay(6),
                  child: circleDay('Sat', context, _isDayOn(6)),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppTextStyle.smallBoldText('Cancel'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final h = _selectedTime.hour;
          final m = _selectedTime.minute;
          Navigator.of(
            context,
          ).pop({'hour': h, 'minute': m, 'repeatMask': _repeatMask});
        },
        backgroundColor: const Color(0xff65d1ba),
        child: const Icon(Icons.check),
      ),
    );
  }
}
