import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routined/core/constants/db_constants.dart';
import 'package:routined/presentation/widgets/add_alarm.dart';

import 'presentation/bottom_bar.dart';
import 'data/models/tasks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive
  await Hive.initFlutter();

  //register adapter
  Hive.registerAdapter(TaskAdapter());
  // Hive.registerAdapter(HabbitAdapter());
  // open a Box

  await Hive.openBox(habbitBox);
  await Hive.openBox(taskBox);
  await Hive.openBox(noteBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routined',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SideBarMenu(),
      routes: {
        AddAlarm.routeName: (context) => const AddAlarm(),
      },
    );
  }
}
