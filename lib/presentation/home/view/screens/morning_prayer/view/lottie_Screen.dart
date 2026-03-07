import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Lottie.asset('assets/lottie/Book with bookmark.json', height: 100.h, width: 100.w)
    );
  }
  Widget shimmer({
    String? name,
    required BuildContext context,
    Color? color,
    double? size,
  }) {
    return Center(
      child: Container(
        child: Lottie.asset(
          name ??  'assets/lottie/Book with bookmark.json',
          width: size,
          height: size,
        ),
      ),
    );
  }
}
