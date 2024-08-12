import 'package:patrol_app/dashboard.dart';
import 'package:patrol_app/sign_up.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define a fixed width for the social buttons
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add Logo at the top
            Image.asset(
              'assets/images/logos/animal_tracking.png', // Replace with your logo path
              height: 100,
            ),
            SizedBox(height: 30),

            // "Welcome Back" text
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // "Fill in the information..."
            Text(
              'Fill in the information below in order to access your account',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Email Text Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            // Password Text Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Sign In Button
            ElevatedButton(
              onPressed: () {
                // Handle sign in action
                Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DashboardScreen(),
                      ),
                    );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Sign in'),
            ),
            SizedBox(height: 20),

            // "Or" with lines
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            SizedBox(height: 20),

            // Social Buttons with fixed width
            SizedBox(
              width: buttonWidth,
              child: _buildSocialButton(
                icon: Image.asset(
                  'assets/images/logos/facebook-white.png', // Your local image path
                  height: 24, // Adjust size as needed
                  width: 24,
                ),
                text: 'Continue with Facebook',
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              child: _buildSocialButton(
                icon: Image.asset(
                  'assets/images/logos/google.png', // Your local image path
                  height: 24, // Adjust size as needed
                  width: 24,
                ),
                text: 'Continue with Google',
                color: Colors.red,
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              child: _buildSocialButton(
                icon: Image.asset(
                  'assets/images/logos/apple-white.png', // Your local image path
                  height: 24,
                  width: 24,
                ),
                text: 'Continue with Apple',
                color: const Color.fromARGB(255, 0, 0, 0),
                onPressed: () {},
              ),
            ),

            SizedBox(height: 20),

            // "Don't have an account? Sign Up Here"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    // Navigate to Sign Up Page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up Here',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Social button widget
  Widget _buildSocialButton({
    required Widget icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      onPressed: onPressed,
    );
  }
}
