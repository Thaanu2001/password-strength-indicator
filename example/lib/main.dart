import 'package:flutter/material.dart';

import 'package:password_strength_indicator/password_strength_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Password Strength Indicator Demo',
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Strength Indicator'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Password field
              TextField(
                decoration: const InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  // Update the password
                  setState(() {
                    password = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: PasswordStrengthIndicator(
                  password: password, // Password to be evaluated
                  width: 500, // Change the width of the strength bar
                  thickness: 12, // Change the thickness of the strength bar
                  backgroundColor: Colors
                      .grey, // Change the background color of the strength bar
                  radius: 8, // Change the radius of the strength bar
                  colors: const StrengthColors(
                    // Customize the colors of the strength bar
                    weak: Colors.orange,
                    medium: Colors.yellow,
                    strong: Colors.green,
                  ),
                  duration: const Duration(
                      milliseconds: 300), // Set the animation duration
                  curve: Curves.easeOut, // Set the animation curve
                  callback: (double strength) {
                    // Receive the strength value of the password
                    print('Password Strength: $strength');
                  },
                  strengthBuilder: (String password) {
                    // Implement a custom strength builder to calculate the strength based on your criteria
                    // Return a value between 0.0 (too weak) and 1.0 (very strong)
                    // Example:
                    return password.length / 10;
                  },
                  style: StrengthBarStyle
                      .line, // Choose a style for the strength bar
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
