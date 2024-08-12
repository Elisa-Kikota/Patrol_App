import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation to the respective screens
    // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => SyncScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                child: Image.asset(
                  'assets/images/logos/animal_tracking_transparent.png',
                  fit: BoxFit.cover,
                  color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.0), // Faint image
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          // Content overlay
          Center(
            child: Text(
              'Dashboard Content Here', // Replace with actual content
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue, // Light blue background
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Sync',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.clear),
            label: 'Clear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
        ],
      ),
    );
  }
}
