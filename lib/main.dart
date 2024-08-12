import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'sign_in.dart';

void main() {
  runApp(PatrolApp());
}

class PatrolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patrol App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/sign_in': (context) => SignInScreen(),
      },
    );
  }
}
