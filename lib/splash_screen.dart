import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textAnimation;
  late Animation<Offset> _image1Animation;
  late Animation<Offset> _image2Animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _textAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.33, curve: Curves.easeInOut)),
    );

    _image1Animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.33, 0.66, curve: Curves.easeInOut)),
    );

    _image2Animation = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.66, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward().then((_) {
      Navigator.pushReplacementNamed(context, '/sign_in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _textAnimation.drive(Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)),
              child: Text(
                'Patrol App',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            SlideTransition(
              position: _image1Animation,
              child: Image.asset(
                'assets/images/logos/udsm.png',
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            SlideTransition(
              position: _image2Animation,
              child: Image.asset(
                'assets/images/logos/animal_tracking.png',
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
