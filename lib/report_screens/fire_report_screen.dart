import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FireReportScreen extends StatefulWidget {
  @override
  _FireReportScreenState createState() => _FireReportScreenState();
}

class _FireReportScreenState extends State<FireReportScreen> {
  String currentLatitude = '12.65656';
  String currentLongitude = '67.97575';
  List<File> _images = [];
  final picker = ImagePicker();
  bool _isSubmitting = false;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String fireStatus = 'Active';
  String causeOfFire = 'Natural';
  String actionTaken = 'Monitoring';

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> submitReport() async {
    setState(() {
      _isSubmitting = true;
    });

    DatabaseReference fireReportsRef = FirebaseDatabase.instance.ref().child('Reports/Fire');
    DatabaseReference newReportRef = fireReportsRef.push();
    String reportID = newReportRef.key!;

    List<String> downloadURLs = [];

    for (var image in _images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/$reportID/$fileName');

      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() => null);

      String downloadURL = await storageReference.getDownloadURL();
      downloadURLs.add(downloadURL);
    }

    await newReportRef.set({
      'location': {
        'Lat': currentLatitude,
        'Long': currentLongitude,
      },
      'size_hectares': double.tryParse(sizeController.text) ?? 0.0,
      'fire_status': fireStatus,
      'cause_of_fire': causeOfFire,
      'action_taken': actionTaken,
      'pictures': downloadURLs,
      'notes': notesController.text,
      'reported_by': 'Officer A', // Replace with dynamic data as needed
      'day': DateTime.now().toIso8601String().split('T').first,
      'time': DateTime.now().toIso8601String().split('T').last.split('.').first,
    });

    setState(() {
      _isSubmitting = false;
      _images.clear();
      locationController.clear();
      sizeController.clear();
      notesController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report submitted successfully!')),
    );
  }

  void viewImage(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(image: image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Report'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report Details', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            // Location of the Fire (Name of Area)
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location of the Fire (Name of Area)',
              ),
            ),
            SizedBox(height: 16),
            // GPS Coordinates Display
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Current Latitude',
                hintText: currentLatitude,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Current Longitude',
                hintText: currentLongitude,
              ),
            ),
            SizedBox(height: 16),
            Text('Location Options', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement 'Use my current location' functionality here
                    setState(() {
                      currentLatitude = '1.45568';
                      currentLongitude = '1.45568';
                    });
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
              controller: sizeController,
              decoration: InputDecoration(
                labelText: 'Size of the fire (in hectares)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            // Fire status
            DropdownButtonFormField<String>(
              value: fireStatus,
              items: ['Active', 'Contained', 'Extinguished']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  fireStatus = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Fire status',
              ),
            ),
            SizedBox(height: 16),
            // Cause of fire
            DropdownButtonFormField<String>(
              value: causeOfFire,
              items: ['Natural', 'Human-induced', 'Unknown']
                  .map((cause) => DropdownMenuItem(
                        value: cause,
                        child: Text(cause),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  causeOfFire = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Cause of fire',
              ),
            ),
            SizedBox(height: 16),
            // Action taken
            DropdownButtonFormField<String>(
              value: actionTaken,
              items: [
                'Monitoring',
                'Extinguishing',
                'Reporting to higher authorities'
              ]
                  .map((action) => DropdownMenuItem(
                        value: action,
                        child: Text(action),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  actionTaken = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Action taken',
              ),
            ),
            SizedBox(height: 16),
            // Pictures and Take Picture Button
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: _images.isNotEmpty
                      ? GestureDetector(
                          onTap: () => viewImage(_images.last),
                          child: Image.file(
                            _images.last,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text('No Image'),
                        ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: getImage,
                  child: Text(_images.isEmpty ? 'Take a Picture' : 'Take Another'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Notes
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            // Submit Report Button
            Center(
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : submitReport,
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : Text('Submit Report'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: _isSubmitting ? Colors.grey : Colors.blue,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewerScreen extends StatelessWidget {
  final File image;

  ImageViewerScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Image'),
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}
