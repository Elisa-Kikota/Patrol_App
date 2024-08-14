import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {

  final List<String> instructions = [
    'Patrol the western zone today due to increased activity.',
    'Ensure all gates are secured before the end of the shift.',
    'New policy update: Report any unusual animal behavior immediately.',
    // Add more instructions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        // backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('Current Location'),
                subtitle: Text('Latitude: 0.000, Longitude: 0.000'), // Replace with actual data
              ),
            ),
            SizedBox(height: 16),

            // Weather Conditions
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.cloud, color: Colors.blue),
                title: Text('Weather Conditions'),
                subtitle: Text('Sunny, 25°C'), // Replace with actual data
              ),
            ),
            SizedBox(height: 16),

            // Recent Alerts
            Text(
              'Recent Alerts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Alert: Unauthorized entry detected'),
                    subtitle: Text('10 mins ago'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to alert details
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Alert: Animal spotted in restricted area'),
                    subtitle: Text('30 mins ago'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to alert details
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Patrol the western zone today due to increased activity.'),
                    subtitle: Text('1 hour ago'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to alert details
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Ensure all gates are secured before the end of the shift.'),
                    subtitle: Text('2 hours ago'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to alert details
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('New policy update: Report any unusual animal behavior immediately'),
                    subtitle: Text('3 hours ago'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to alert details
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
