import 'package:flutter/material.dart';
import 'report_screens/fire_report_screen.dart';
import 'report_screens/human_wildlife_contact_report_screen.dart';
import 'report_screens/injured_animal_report_screen.dart';
import 'report_screens/invasive_species_sighting_report_screen.dart';
import 'report_screens/rainfall_report_screen.dart';
import 'report_screens/rhino_sighting_report_screen.dart';
import 'report_screens/wildlife_sighting_report_screen.dart';
import 'report_screens/ct_icon_sighting_report_screen.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ReportButton(title: 'Fire', route: FireReportScreen()),
          ReportButton(title: 'Human-Wildlife Contact', route: HumanWildlifeContactReportScreen()),
          ReportButton(title: 'Injured Animal', route: InjuredAnimalReportScreen()),
          ReportButton(title: 'Invasive Species Sighting', route: InvasiveSpeciesSightingReportScreen()),
          ReportButton(title: 'Rainfall', route: RainfallReportScreen()),
          ReportButton(title: 'Rhino Sighting', route: RhinoSightingReportScreen()),
          ReportButton(title: 'Wildlife Sighting', route: WildlifeSightingReportScreen()),
          ReportButton(title: 'CT Icon Sighting', route: CTIconSightingReportScreen()),
        ],
      ),
    );
  }
}

class ReportButton extends StatelessWidget {
  final String title;
  final Widget route;

  ReportButton({required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Text(title),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue, // Text color
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
