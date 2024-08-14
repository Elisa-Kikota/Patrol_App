import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CategoryButton(title: 'Monitoring'),
          CategoryButton(title: 'Security'),
          CategoryButton(title: 'Logistics'),
          CategoryButton(title: 'Vulture Clusters'),
          CategoryButton(title: 'Zoologico'),
          CategoryButton(title: 'Community'),
          CategoryButton(title: 'Baotree Reports'),
          CategoryButton(title: 'DevOcean Events'),
          CategoryButton(title: 'GearManufacturer Events'),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;

  CategoryButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          // Implement button action here
        },
        child: Text(title),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
