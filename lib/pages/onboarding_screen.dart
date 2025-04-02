import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Start Now',
        finishButtonStyle: FinishButtonStyle(backgroundColor: Colors.black),
        totalPage: 3,
        speed: 1.8,
        onFinish: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        background: [
          _buildBackgroundImage('assets/BG1.jpg'),
          _buildBackgroundImage('assets/BG2.jpg'),
          _buildBackgroundImage('assets/BG3.jpg'),
        ],
        pageBodies: [
          _buildPage("Description Text 1"),
          _buildPage("Description Text 2"),
          _buildPage("Description Text 3"),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPage(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
