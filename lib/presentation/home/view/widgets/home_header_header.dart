import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'prayer_shimmer.dart';
import 'reference_shimmer.dart';

class HomeHeaderSection<T> extends StatelessWidget {
  const HomeHeaderSection({
    super.key,
    required this.asyncValue,
    required this.verseTextBuilder,
    required this.referenceBuilder,
    this.backgroundImageAssetPath = 'assets/images/home_upper.png',
    this.lottieAssetPath = 'assets/lottie/Book with bookmark.json',
  });

  final AsyncValue<T> asyncValue;
  final String Function(T data) verseTextBuilder;
  final String Function(T data) referenceBuilder;
  final String backgroundImageAssetPath;
  final String lottieAssetPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(backgroundImageAssetPath),
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 100.h,
          top: 20.h,
          child: Lottie.asset(lottieAssetPath, height: 700.h, width: 700.w),
        ),
        Positioned(
          bottom: 30.h,
          left: 5.w,
          right: 5.w,
          child: Padding(
            padding: EdgeInsets.all(15.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    asyncValue.when(
                      data: (data) => Text(
                        verseTextBuilder(data),
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          fontSize: 18.sp,
                          color: ColorsManager.whiteColor,
                        ),
                      ),
                      error: (e, _) => Text(e.toString()),
                      loading: () => const PrayerShimmer(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: asyncValue.when(
                        data: (data) => Text(
                          referenceBuilder(data),
                          textAlign: TextAlign.end,
                          style: GoogleFonts.merriweather(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        error: (e, _) => Text(e.toString()),
                        loading: () => const ReferenceShimmer(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
