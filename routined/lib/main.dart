import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/features/widgets/add_alarm.dart';
import 'package:routined/core/services/notification_service.dart';
import 'package:routined/data/repository/database_connection.dart';

import 'features/sidebar_nav.dart';
import 'features/settings/view/settings_screen.dart';
import 'splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite for Android
  await initializeSqlite();

  // Initialize notifications service once at app start
  await NotificationService.instance.init();

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
      home: const SplashScreen(),
      routes: {
        SideBarMenu.routeName: (context) => const SideBarMenu(),
        AddAlarm.routeName: (context) => const AddAlarm(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
    );
  }
}

