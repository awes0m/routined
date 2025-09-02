import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/globals.dart';
import '../common/side_navigation/side_navigation.dart';
import 'habbit_tracker/view/habbit_tracker_view.dart';
import 'notepad/notepad.dart';
import 'reminders/reminders_screen.dart';
import 'expense_tracker/view/expense_screen.dart';
import 'tasks/view/tasks_screen.dart';
import 'settings/view/settings_screen.dart';

class SideBarMenu extends StatefulWidget {
  static const String routeName = "/main-nav";
  const SideBarMenu({super.key});

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const HabbitTrackerView(),
    const TasksScreen(),
    const NotesScreen(),
    const RemindersScreen(),
    const ExpenseScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.drawerKey,
      drawer: SideNavigationBar(
        toggler: const SideBarToggler(),
        initiallyExpanded: false,
        expandable: true,
        theme: SideNavigationBarTheme(
          backgroundColor: kCaptionColor,
          dividerTheme: SideNavigationBarDividerTheme.standard(),
          itemTheme: SideNavigationBarItemTheme.standard(),
          togglerTheme: const SideNavigationBarTogglerTheme(
            expandIconColor: kPrimaryColor,
            shrinkIconColor: kSecondaryBackgroundColor,
          ),
        ),
        // type: SideNavigationBarType.fixed,
        selectedIndex: _selectedIndex,

        onTap: _onItemTapped,
        items: const <SideNavigationBarItem>[
          SideNavigationBarItem(icon: Icons.sunny, label: 'Habits'),
          SideNavigationBarItem(icon: Icons.track_changes, label: 'To Do'),
          SideNavigationBarItem(icon: Icons.note, label: 'Notes'),
          SideNavigationBarItem(icon: Icons.alarm, label: 'Alarms'),
          SideNavigationBarItem(
            icon: Icons.account_balance_wallet,
            label: 'Expenses',
          ),
          SideNavigationBarItem(icon: Icons.settings, label: 'Settings'),
        ],
      ),
      body: screens.elementAt(_selectedIndex), //Switches to selected screen
    );
  }
}
