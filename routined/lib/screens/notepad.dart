import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Notes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              )),
        ),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Notes'),
      ),
      backgroundColor: Colors.white,
    );
  }
}
