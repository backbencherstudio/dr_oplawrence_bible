import 'package:dr_oplawrence_bible/presentation/onboarding/second_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/onboarding_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 60.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SecondOnboarding()),
                );
              },
              child: Image.asset(
                'assets/icons/onboarding_button.png',
                scale: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
