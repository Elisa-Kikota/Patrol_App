import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('PatrolOfficers');

  String _name = '';
  String _email = '';
  String _phone = '';
  String _role = '';
  String _profileImageUrl = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DataSnapshot snapshot = await _dbRef.child(user.uid).get();

      if (snapshot.value != null) {
        Map<String, dynamic> profileData = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        setState(() {
          _name = profileData['name'] ?? '';
          _email = profileData['email'] ?? '';
          _phone = profileData['phone'] ?? '';
          _role = profileData['role'] ?? '';
          _profileImageUrl = profileData['profile_picture_url'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImageUrl.isNotEmpty
                          ? NetworkImage(_profileImageUrl)
                          : AssetImage('assets/images/default_profile.png') as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileField('Name', _name),
                  SizedBox(height: 10),
                  _buildProfileField('Email', _email),
                  SizedBox(height: 10),
                  _buildProfileField('Phone', _phone),
                  SizedBox(height: 10),
                  _buildProfileField('Role', _role),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(
                              name: _name,
                              phone: _phone,
                              role: _role,
                              profileImageUrl: _profileImageUrl,
                            ),
                          ),
                        );
                      },
                      child: Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
