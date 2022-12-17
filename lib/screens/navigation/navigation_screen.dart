import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/navigation/doctor_list_screen.dart';
import '/screens/navigation/educational_resources_screen.dart';
import '/screens/navigation/menu_screen.dart';

import '/screens/home/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const EducationalResourcesScreen(),
    const DoctorListScreen(),
    const MenuScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: const Text("Do you want to close the app?"),
            actions: [
              TextButton(
                onPressed: () => SystemNavigator.pop(animated: true),
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int newIndex) => setState(() {
            index = newIndex;
          }),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_outlined,
              ),
              label: 'Resources',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.health_and_safety_outlined,
              ),
              label: 'Doctors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
