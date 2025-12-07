import 'package:dr_oplawrence_bible/presentation/auth/login_screen.dart';
import 'package:dr_oplawrence_bible/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SecondOnboarding extends StatefulWidget {
  const SecondOnboarding({super.key});

  @override
  State<SecondOnboarding> createState() => _SecondOnboardingState();
}

class _SecondOnboardingState extends State<SecondOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/second_on_back.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1F3B96),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Login'),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffCDA434),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                );
              },
              child: const Text('Continue as Guest',style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}
