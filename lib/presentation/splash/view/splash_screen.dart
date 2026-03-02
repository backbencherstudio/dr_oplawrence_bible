import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/route/route_name.dart';
import '../../../data/sources/local/shared_preference/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Wait for 2 seconds (splash delay)
    await Future.delayed(const Duration(seconds: 2));

    // Get token from SharedPreferences
    final token = await SharedPreferenceData.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // User is logged in → Go to home screen
      Navigator.pushReplacementNamed(context, RouteNames.parentScreen);
    } else {
      // User not logged in → Go to onboarding/login screen
      Navigator.pushReplacementNamed(context, RouteNames.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 250,
            left: 30,
            right: 30,
            child: Image.asset('assets/icons/splash_icon.png', scale: 5),
          ),
        ],
      ),
    );
  }
}
