import 'dart:ui';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      body: SafeArea(
        child: SizedBox(
          height: Utils.fullHeight(context) * 0.80,
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/home_upper.png'),
                    Positioned(
                      top: 50.h,
                      left: 10.w,
                      right: 10.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 320.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.white70),
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 10,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    child: Image.asset(
                                      'assets/images/user.png',
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hi YAH'USHUA HAMASHIACH",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color(0xffF7F5EF),
                                        ),
                                      ),
                                      Text(
                                        'God Bless You',
                                        style: GoogleFonts.merriweather(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          color: Color(0xffFAD33E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.w),
                                  // SvgPicture.asset('assets/icons/Bell.svg'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160.h,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 30,
                          children: [
                            Row(
                              spacing: 200,
                              children: [
                                Text(
                                  'Verse of the day',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );

                                    if (selectedDate != null) {
                                      if (kDebugMode) {
                                        print(selectedDate);
                                      }
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/calender_type.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              textAlign: TextAlign.center,
                              '''God is YAHAWAH ELOHIYM\nLord is YAHAWAH\n Amen is Ommah\nJesus Christ is YAH'USHUA HAMASHIACH''',

                              style: GoogleFonts.merriweather(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),

                            // Text(
                            //   'GENESIS 1:3 >>',
                            //   style: TextStyle(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w400,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            Row(
                              spacing: 30,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.glossaryScreen,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/share.svg',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.bookListScreen,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/notes.svg',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prayer of the day',
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      Image.asset('assets/images/prayer_day.png'),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            spacing: 15,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Morning Pray',
                                        style: GoogleFonts.merriweather(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Color(0xff1A1A1A),
                                        ),
                                      ),
                                      Text(
                                        'Start Your Day With This Verse',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff4A4A4A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset('assets/images/tree.svg'),
                                ],
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.morningPrayerScreen,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1F3B96),
                                ),
                                child: Center(child: Text('Start')),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            spacing: 15,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Gospel & Psalms of the Day',
                                        style: GoogleFonts.merriweather(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Color(0xff1A1A1A),
                                        ),
                                      ),
                                      Text(
                                        'Start Your Day With This Verse',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff4A4A4A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset('assets/images/star.svg'),
                                ],
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.gospelPsalmScreen,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1F3B96),
                                ),
                                child: Center(child: Text('Start')),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        spacing: 20,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.highlightsScreen,
                              );
                            },
                            child: Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  spacing: 9,
                                  children: [
                                    SvgPicture.asset('assets/images/star.svg',width: 40.w,height: 40.h,),
                                    Text(
                                      'Highlight',
                                      style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.bookListScreen,
                              );
                            },
                            child: Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  spacing: 5,
                                  children: [
                                    SizedBox(
                                      width: 43,
                                      height: 43,
                                      child: Image.asset(
                                        'assets/icons/login_icons.png',
                                      ),
                                    ),
                                    Text(
                                      'Bible',
                                      style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Color(0xff1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.glossaryScreen,
                              );
                            },
                            child: Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  spacing: 5,
                                  children: [
                                    SizedBox(
                                      width: 43,
                                      height: 43,
                                      child: SvgPicture.asset(
                                        'assets/icons/searching.svg',
                                      ),
                                    ),
                                    Text(
                                      'Glossary',
                                      style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Color(0xff1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.archievedDailyDevotionalsScreen,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/greetings.svg'),
                                Text(
                                  'Archived Daily Devotionals',
                                  style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Color(0xff1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Text(
                        'GOD’s words for today',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xff4A4A4A),
                        ),
                      ),

                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                ' Any Topic ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xff1A1A1A),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/barakat.svg'),
                                  Text(
                                    'Barakat  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/peace.svg'),
                                  Text(
                                    'Peace ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/love.svg'),
                                  Text(
                                    ' Love ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/Salvation.svg',
                                  ),
                                  Text(
                                    'Salvation  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/Faith.svg'),
                                  Text(
                                    'Faith ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
