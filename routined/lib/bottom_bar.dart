import 'package:flutter/material.dart';

import 'presentation/screens/alarm_screen.dart';
import 'presentation/screens/notepad.dart';
import 'presentation/screens/to_do_screen.dart';
import 'presentation/screens/weather_search_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const WeatherSearchPage(),
    const ToDoScreen(),
    const NotesScreen(),
    const AlarmScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black87,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sunny),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'To Do',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Alarms',
            ),
          ],
        ),
      ),
      body: screens.elementAt(_selectedIndex), //Switches to selected screen
    );
  }
}
