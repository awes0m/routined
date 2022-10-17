import 'package:flutter/material.dart';
import 'package:routined/core/widgets/custom_appbar.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: 'Alarms'),
      body: const Center(
        child: Text('Alarms'),
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }
}
