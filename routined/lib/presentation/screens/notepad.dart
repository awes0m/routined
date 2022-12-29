import 'package:flutter/material.dart';
import 'package:routined/core/widgets/custom_appbar.dart';

import '../../core/common/globals.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

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
