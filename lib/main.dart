import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/onboarding_screen.dart';
import 'pages/home_screen.dart';
import 'pages/wallet.dart';

import 'models/income_model.dart';
import 'models/expense_model.dart';  // ✅ Import the ExpenseModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncomeModel()),
        ChangeNotifierProvider(create: (_) => ExpenseModel()),  // ✅ Added ExpenseModel
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'roboto',
        primaryColor: Color(0xFF0666EB),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // home: OnboardingScreen(), // Show onboarding first
      home: HomeScreen(), // Show onboarding first
      routes: {
        '/home': (context) => HomeScreen(), // Define home screen
      },
    );
  }
}
