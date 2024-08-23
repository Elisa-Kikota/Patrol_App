import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:patrol_app/dashboard.dart';
// import 'package:patrol_app/map_screen.txt';
import 'package:patrol_app/task_screen.dart';
import 'report_screen.dart'; // Import the CategoriesScreen

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    DashboardScreen(),  // DashBoard Screen
    TaskScreen(), // Clear Screen
    Center(child: Text('Map Screen')),
    ReportScreen(),                  // Categories Screen
    Center(child: Text('Profile Screen')) // Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            backgroundColor: Colors.blue,
            tabBackgroundColor: Colors.blue.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: _onItemTapped, // Change the tab
            tabs: [
              GButton(
                icon: Icons.dashboard,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.task,
                text: 'Task',
              ),
              GButton(
                icon: Icons.map,
                text: 'Map',
              ),
              GButton(
                icon: Icons.report,
                text: 'Report',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
