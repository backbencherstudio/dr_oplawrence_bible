import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/morningshimmer.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/screens/morning_prayer/viewmodel/morning_prayer_riverpod.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/prayer_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reference_shimmer.dart';

class MorningPrayerScreen extends ConsumerStatefulWidget {
  const MorningPrayerScreen({super.key});

  @override
  ConsumerState<MorningPrayerScreen> createState() =>
      _MorningPrayerScreenState();
}

class _MorningPrayerScreenState extends ConsumerState<MorningPrayerScreen> {
  @override
  Widget build(BuildContext context) {
    final morningPrayer = ref.watch(morningPrayerRiverpod);
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/morning_background.png'),
                Positioned(
                  top: 60.h,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    spacing: 30.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/cross.png',
                            scale: 3,
                          ),
                        ),
                      ),

                      Text(
                        textAlign: TextAlign.center,
                        'Verse of the day',
                        style: GoogleFonts.merriweather(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1A1A1A),
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Image.asset('assets/images/Line.png', scale: 3),
                          morningPrayer.when(
                            data: (data) {
                              return Text(
                                textAlign: TextAlign.center,
                                data.maditaionVerse?.reference ?? 'reference',
                                style: GoogleFonts.merriweather(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4A4A4A),
                                ),
                              );
                            },
                            error: (e, _) => Text(e.toString()),
                            loading: () =>ReferenceShimmer(),
                          ),

                          Image.asset('assets/images/Line.png', scale: 3),
                        ],
                      ),

                      morningPrayer.when(
                        data: (data) {
                          return Text(
                            textAlign: TextAlign.center,
                            data.maditaionVerse?.text ?? "",
                            style: GoogleFonts.merriweather(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffF7F5EF),
                            ),
                          );
                        },
                        error: (e, _) => Text(e.toString()),
                        loading: () => MorningPrayerShimmer(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding:  EdgeInsets.all(16.0.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Meditation',
                        style: GoogleFonts.merriweather(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      morningPrayer.when(
                        data: (data) {
                          return Text(
                            data.maditaionVerse?.text ?? '',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff4A4A4A),
                              height: 1.4.h,
                              letterSpacing: 0.6.w,
                              wordSpacing: 2.0.w,
                            ),
                          );
                        },
                        error: (e, _) => Text(e.toString()),
                        loading: () => PrayerShimmer(),
                      ),

                      SizedBox(height: 10.h),
                      Text(
                        'Pray',
                        style: GoogleFonts.merriweather(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      morningPrayer.when(
                        data: (data) {
                          return Text(
                            textAlign: TextAlign.center,
                            data.prayer ?? "",
                            style: GoogleFonts.merriweather(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff4A4A4A),
                              height: 1.4.h,
                              letterSpacing: 0.6.w,
                              wordSpacing: 2.0.w,
                            ),
                          );
                        },
                        error: (e, _) => Text(e.toString()),
                        loading: () => PrayerShimmer(),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffCDA434),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.prayerScreen);
                        },
                        child: Center(
                          child: Text(
                            'Omnah',
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
    );
  }
}
