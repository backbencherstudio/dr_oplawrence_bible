import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dotted_divider.dart';

class GospelPsalmScreen extends StatefulWidget {
  const GospelPsalmScreen({super.key});

  @override
  State<GospelPsalmScreen> createState() => _GospelPsalmScreenState();
}

class _GospelPsalmScreenState extends State<GospelPsalmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      body: SafeArea(
        child: Stack(
          children: [

            Positioned.fill(
              child: Image.asset(
                'assets/images/morning_background.png',
                fit: BoxFit.cover,
              ),
            ),


            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/cross.png', scale: 3)),
                      Image.asset('assets/images/play_music.png', scale: 3),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  Image.asset('assets/images/morning_image.png', scale: 3),

                  SizedBox(height: 20.h),

                  Text(
                    'Gospel of the Day',
                    style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff1A1A1A),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Line.png', scale: 3),
                      SizedBox(width: 10.w),
                      Text(
                        'Matthew 2:1',
                        style: GoogleFonts.merriweather(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff4A4A4A),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Image.asset('assets/images/Line.png', scale: 3),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    '“Now when YAH’USHUA was born in Bethlehem of Yehudaea in the days of Herod the king, behold, there came wise men from the east to Yerushalayim.”',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: const Color(0xffF7F5EF),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/share.png', scale: 3),
                      SizedBox(width: 40.w),
                      Image.asset('assets/images/document.png', scale: 3),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  DottedDivider(
                    height: 2,
                    dotWidth: 6,
                    spacing: 6,
                    color: Colors.black45,
                  ),

                  SizedBox(height: 20.h),

                  Image.asset('assets/images/tree_image.png'),
                  SizedBox(height: 20.h),
                  Text(
                    'Psalms of the Day',
                    style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff1A1A1A),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Line.png', scale: 3),
                      SizedBox(width: 10.w),
                      Text(
                        'Psalms 1:1',
                        style: GoogleFonts.merriweather(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff4A4A4A),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Image.asset('assets/images/Line.png', scale: 3),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    '“Barakat is the man that walketh not in the  counsel of the rasha, nor standeth in the way  of sinners, nor sitteth in the seat of the scornful.”',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: const Color(0xffF7F5EF),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
