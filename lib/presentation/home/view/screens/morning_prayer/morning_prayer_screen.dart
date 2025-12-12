import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MorningPrayerScreen extends StatefulWidget {
  const MorningPrayerScreen({super.key});

  @override
  State<MorningPrayerScreen> createState() => _MorningPrayerScreenState();
}

class _MorningPrayerScreenState extends State<MorningPrayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/morning_background.png'),
                  Positioned(
                    top: 80.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
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
                  ),
                  Positioned(
                    top: 165.h,
                    right: 60.w,
                    left: 110.w,
                    child: Text(
                      'Verse of the day',
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200.h,
                    right: 60.w,
                    left: 95.w,
                    child: Row(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/Line.png', scale: 3),
                        Text(
                          'GENESIS 1:6',
                          style: GoogleFonts.merriweather(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4A4A4A),
                          ),
                        ),
                        Image.asset('assets/images/Line.png', scale: 3),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 250.h,
                    right: 40.w,
                    left: 50.w,
                    child: Text(
                      '“And ELOHIYM said, Let there be a firmament in the midst of the waters, and let it divide the waters from the waters.”',
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffF7F5EF),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Meditation',
                          style: GoogleFonts.merriweather(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A),
                          ),
                        ),
                        Text(
                          "YAH helps us transform. Like a caterpillar, it's hard work, but with faith, we can take flight. God is with us, working for our good.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.merriweather(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4A4A4A),
                            height: 1.4,
                            letterSpacing: 0.6,
                            wordSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Pray',
                          style: GoogleFonts.merriweather(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Heavenly Father, we’re so grateful for Your never-ending presence in our lives. You are a loving reminder that You are always with us, even in our most difficult times, helping us to become stronger and wiser.  Amen.",
                          style: GoogleFonts.merriweather(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4A4A4A),
                            height: 1.4,
                            letterSpacing: 0.6,
                            wordSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffCDA434),
                          ),
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'Amen',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
