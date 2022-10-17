import 'package:flutter/material.dart';
import 'package:routined/core/widgets/custom_appbar.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: 'Notes'),
      body: const Center(
        child: Text('Notes'),
      ),
      backgroundColor: Colors.white,
    );
  }
}
