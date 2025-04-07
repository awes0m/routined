import 'package:flutter/material.dart';
import 'package:routined/common/custom_appbar.dart';

import '../../core/globals.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: 'Notes',key: Globals.drawerKey),
      body: const Center(
        child: Text('Notes'),
      ),
      backgroundColor: Colors.white,
    );
  }
}
