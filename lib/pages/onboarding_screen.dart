import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        finishButtonText: 'Start Now',
        skipTextButton: Text('Skip'),
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: const Color(0xFF066EBB),

        ),
        background: [Text(' '), Text(' ')], // Keeps default package format
        totalPage: 2,
        speed: 1.8,
        onFinish: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        pageBodies: [
          _buildOnboardingPage(
            title: 'Student Expense App',
            subtitle: 'Stay within budget and avoid surprise expenses.',
            image: 'assets/savings.png',
          ),
          _buildOnboardingPage(
            title: 'Get Started',
            subtitle: 'Monitor where your money goes, effortlessly.',
            image: 'assets/invest.png',
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Column(
      children: [
       Image.asset(image, fit: BoxFit.cover), 
        Expanded(
          flex: 2, // Gives 2/5 of space to text content
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF919191),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
