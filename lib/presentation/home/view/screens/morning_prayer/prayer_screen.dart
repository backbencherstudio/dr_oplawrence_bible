import 'dart:ui';

import 'package:flutter/material.dart';
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



      body: Container(
        child: Stack(
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
                child: Center(child: Column(
                  children: [ Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/cross.png',
                        scale: 3,
                      ),
                    ),
                  ),SizedBox(height: 120,),
                    Image.asset('assets/images/img_1.png',scale: 3.5,),
                  ],
                ))),
            Positioned(
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "In Yeshua' name Thank you, Adonai Barakat us, O Adonai",
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
