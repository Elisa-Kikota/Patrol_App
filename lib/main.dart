import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';
import 'main_page.dart';
import 'sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already signed in
  bool isSignedIn = await checkIfSignedIn();

  runApp(PatrolApp(isSignedIn: isSignedIn));
}

Future<bool> checkIfSignedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  return email != null;
}

class PatrolApp extends StatelessWidget {
  final bool isSignedIn;

  PatrolApp({required this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patrol App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isSignedIn ? MainPage() : SplashScreen(),
      routes: {
        '/sign_in': (context) => SignInScreen(),
      },
    );
  }
}
