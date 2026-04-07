import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

          /// Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/second_on_back.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Login Button
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 160.h,
            child: SizedBox(
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.loginScreen,
                    (route) => false,
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          /// Continue as Guest
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 90.h,
            child: SizedBox(
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffCDA434),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.parentScreen,
                    (route) => false,
                  );
                },
                child: Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}