import 'package:dr_oplawrence_bible/presentation/onboarding/second_onboarding.dart';
import 'package:flutter/material.dart';

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
          Image.asset('assets/images/onboarding_screen.png'),
          Positioned(
              bottom: 60,
              right: 20,
              child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondOnboarding()));
                  },
                  child: Image.asset('assets/icons/onboarding_button.png',scale: 3,))),
        ],
      ),
    );
  }
}
