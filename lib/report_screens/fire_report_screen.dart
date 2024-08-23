import 'package:flutter/material.dart';

class FireReportScreen extends StatefulWidget {
  @override
  _FireReportScreenState createState() => _FireReportScreenState();
}

class _FireReportScreenState extends State<FireReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Report'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report Details', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            // Location of the Fire
            TextField(
              decoration: InputDecoration(
                labelText: 'Location of the Fire (GPS coordinates)',
              ),
            ),
            SizedBox(height: 16),
            Text('Location Options', style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement 'Use my current location' functionality here
                  },
                  child: Text('Use my current location'),
                ),
                SizedBox(width: 16),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement 'Adjust by map from current location' functionality here
                  },
                  child: Text('Adjust by map from current location'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Size of the fire
            TextField(
              decoration: InputDecoration(
                labelText: 'Size of the fire (in hectares)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            // Fire status
            DropdownButtonFormField<String>(
              items: ['Active', 'Contained', 'Extinguished']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle fire status selection
              },
              decoration: InputDecoration(
                labelText: 'Fire status',
              ),
            ),
            SizedBox(height: 16),
            // Cause of fire
            DropdownButtonFormField<String>(
              items: ['Natural', 'Human-induced', 'Unknown']
                  .map((cause) => DropdownMenuItem(
                        value: cause,
                        child: Text(cause),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle cause of fire selection
              },
              decoration: InputDecoration(
                labelText: 'Cause of fire',
              ),
            ),
            SizedBox(height: 16),
            // Action taken
            DropdownButtonFormField<String>(
              items: ['Monitoring', 'Extinguishing', 'Reporting to higher authorities']
                  .map((action) => DropdownMenuItem(
                        value: action,
                        child: Text(action),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle action taken selection
              },
              decoration: InputDecoration(
                labelText: 'Action taken',
              ),
            ),
            SizedBox(height: 16),
            // Pictures
            ElevatedButton(
              onPressed: () {
                // Implement take picture functionality here
              },
              child: Text('Take a Picture'),
            ),
            SizedBox(height: 16),
            // Notes
            TextField(
              decoration: InputDecoration(
                labelText: 'Notes',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement form submission here
              },
              child: Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on TextTheme {
  get subtitle1 => null;
}
