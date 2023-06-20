import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/screens/activate_tag_screen/activate_tag_screen.dart';

import 'home_screen/home_screen.dart';
import 'settings_screen/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  final List<String> _appBarTitle = [
    "Home",
    "Activate Tag",
    "Profile",
  ];

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).textTheme.displayLarge!.color,
        items: [
          bottomBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            title: "Home",
          ),
          bottomBarItem(
            icon: Icons.list,
            activeIcon: Icons.list,
            title: "Activate Tag",
          ),
          bottomBarItem(
            icon: Icons.settings,
            activeIcon: Icons.settings,
            title: "Settings",
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  Future<void> onTabTapped(int index) async {
    if (!mounted) return;
    setState(() => _currentIndex = index);
  }

  BottomNavigationBarItem bottomBarItem(
      {required IconData icon,
      required IconData activeIcon,
      required String title}) {
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).colorScheme.background,
      icon: Icon(
        icon,
        size: 25,
      ),
      activeIcon: Icon(
        activeIcon,
        size: 25,
        color: kPrimaryColor,
      ),
      label: title,
    );
  }

  void initData() {
    _children = [];
    _children.add(HomeScreen());
    _children.add(ActivateTagScreen());
    _children.add(SettingsScreen());
  }
}
