import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatefulWidget {
  const LottieScreen({super.key});

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child:Lottie.asset(
          'assets/lottie/okk.json',
          width: 300,
          height: 300,
          fit: BoxFit.cover,
          repeat: true,
          animate: true,
          reverse: false,
        ),
      ),
    );
  }
}
