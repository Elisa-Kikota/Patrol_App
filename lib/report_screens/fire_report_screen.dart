import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class FireReportScreen extends StatefulWidget {
  @override
  _FireReportScreenState createState() => _FireReportScreenState();
}

class _FireReportScreenState extends State<FireReportScreen> {
  String currentLatitude = '--';
  String currentLongitude = '--';
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

  Future<int> _getNextReportIndex() async {
    DatabaseReference fireReportsRef = FirebaseDatabase.instance.ref().child('Reports/Fire');
    DatabaseEvent event = await fireReportsRef.once();

    if (event.snapshot.exists) {
      dynamic value = event.snapshot.value;
      List<int> keys = [];

      if (value is List) {
        for (int i = 0; i < value.length; i++) {
          if (value[i] != null) {
            keys.add(i);
          }
        }
      } else if (value is Map) {
        keys = value.keys.map((key) => int.tryParse(key.toString()) ?? 0).toList();
      }

      if (keys.isNotEmpty) {
        keys.sort();
        return keys.last + 1;
      }
    }

    return 1; // Start with index 1 if no reports exist or if there's an error
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLatitude = position.latitude.toString();
        currentLongitude = position.longitude.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> submitReport() async {
    setState(() {
      _isSubmitting = true;
    });

    int reportID = await _getNextReportIndex();

    DatabaseReference fireReportsRef = FirebaseDatabase.instance.ref().child('Reports/Fire');

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

    Map<String, dynamic> reportData = {
      'reportID': reportID,
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
    };

    await fireReportsRef.child(reportID.toString()).set(reportData);

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
            // GPS Coordinates Display
Row(
  children: [
    Text(
      'Latitude: ',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    Text(
      currentLatitude,
    ),
  ],
),
SizedBox(height: 8),
Row(
  children: [
    Text(
      'Longitude: ',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    Text(
      currentLongitude,
    ),
  ],
),

            SizedBox(height: 16),
            Text('Location Options', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _getCurrentLocation,
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
            // Pictures and Take Picture Button
Wrap(
  spacing: 8.0,
  runSpacing: 8.0,
  children: _images.map((image) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          child: GestureDetector(
            onTap: () => viewImage(image),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _images.remove(image);
              });
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }).toList(),
),
SizedBox(height: 16),
ElevatedButton(
  onPressed: getImage,
  child: Text(_images.isEmpty ? 'Take a Picture' : 'Take Another'),
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
