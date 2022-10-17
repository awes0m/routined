import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bottom_bar.dart';
import 'data/models/tasks.dart';

Future<void> main() async {
  // init hive
  await Hive.initFlutter();
  //register adapter
  Hive.registerAdapter(TaskAdapter());
  // open a Box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Routined',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BottomBar());
  }
}
