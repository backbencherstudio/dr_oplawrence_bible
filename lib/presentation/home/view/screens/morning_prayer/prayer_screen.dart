import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/morning_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 520,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/cross.png', scale: 3),
                    ),
                  ),
                  SizedBox(height: 120),
                  SvgPicture.asset(
                    'assets/icons/Prayer.svg',
                    width: 100.w,
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "In Yeshua' name\nThank you, Adonai\nBarakat us, O Adonai",
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
