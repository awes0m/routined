import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/features/widgets/add_alarm.dart';
import 'package:routined/data/repository/database_connection.dart';

import 'features/bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite for Android
  await initializeSqlite();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routined',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SideBarMenu(),
      routes: {AddAlarm.routeName: (context) => const AddAlarm()},
    );
  }
}
