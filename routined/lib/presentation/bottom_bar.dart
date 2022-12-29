import 'package:flutter/material.dart';
import 'package:routined/core/common/colors.dart';
import 'package:routined/core/common/globals.dart';
import 'package:side_navigation/side_navigation.dart';

import 'screens/reminders_screen.dart';
import 'screens/notepad.dart';
import 'screens/to_do_screen.dart';
import 'screens/habbit_tracker_page.dart';

class SideBarMenu extends StatefulWidget {
  static const String routeName = "/main-nav";
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const HabbitTrackerPage(),
    const ToDoScreen(),
    const NotesScreen(),
    const RemindersScreen(),
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
              shrinkIconColor: kSecondaryBackgroundColor),
        ),
        // type: SideNavigationBarType.fixed,
        selectedIndex: _selectedIndex,

        onTap: _onItemTapped,
        items: const <SideNavigationBarItem>[
          SideNavigationBarItem(
            icon: Icons.sunny,
            label: 'Habbits',
          ),
          SideNavigationBarItem(
            icon: Icons.track_changes,
            label: 'To Do',
          ),
          SideNavigationBarItem(
            icon: Icons.note,
            label: 'Notes',
          ),
          SideNavigationBarItem(
            icon: Icons.alarm,
            label: 'Alarms',
          ),
        ],
      ),
      body: screens.elementAt(_selectedIndex), //Switches to selected screen
    );
  }
}
