import 'package:flutter/material.dart';
import 'pages/onboarding_screen.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(), // Show onboarding first
      routes: {
        '/home': (context) => HomeScreen(), // Define home screen
      },
    );
  }
}
