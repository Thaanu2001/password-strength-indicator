import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:password_strength_checker/util/strength_bar_style.dart';
import 'package:password_strength_checker/util/strength_colors.dart';

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
        title: const Text('Password Strength Checker'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              const Text('Default style'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
              ),
              const SizedBox(height: 50),
              const Text('Dashed style'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
                style: StrengthBarStyle.dashed,
              ),
              const SizedBox(height: 50),
              const Text('Custom colors'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
                colors: const StrengthColors(
                  weak: Colors.orange,
                  medium: Colors.lightBlue,
                  strong: Colors.lightGreen,
                ),
                backgroundColor: Colors.black,
              ),
              const SizedBox(height: 50),
              const Text('Custom colors'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
                colors: const StrengthColors(
                  weak: Colors.orange,
                  medium: Colors.lightBlue,
                  strong: Colors.lightGreen,
                ),
                style: StrengthBarStyle.dashed,
                backgroundColor: Colors.black,
                thickness: 15,
              ),
              const SizedBox(height: 50),
              const Text('Custom sizes'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
                thickness: 18,
                radius: 0,
              ),
              const SizedBox(height: 50),
              const Text('Custom animation'),
              const SizedBox(height: 8),
              PasswordStrengthChecker(
                password: password,
                duration: const Duration(milliseconds: 800),
                curve: Curves.bounceOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
