import 'package:flutter/material.dart';
import 'all_screens.dart';
import 'package:gooonj_app/theme.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  List<Widget> activeScreen = [HomeScreen(), MapScreen(), FAQScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activeScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: mainBlue,
        selectedItemColor: mainRed,
        onTap: _onItemTapped,
        selectedLabelStyle: bottomBarTextStyle,
        unselectedLabelStyle: bottomBarTextStyle,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Location',
              activeIcon: Icon(Icons.location_pin)),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'FAQ',
              activeIcon: Icon(Icons.info)),
        ],
      ),
    );
  }
}
