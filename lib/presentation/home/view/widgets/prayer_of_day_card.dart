import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'prayer_shimmer.dart';

class PrayerOfDayCard<T> extends StatelessWidget {
  const PrayerOfDayCard({
    super.key,
    required this.asyncValue,
    required this.textBuilder,
    required this.backgroundImageAssetPath,
    this.height = 200,
    this.borderRadius = 16,
  });

  final AsyncValue<T> asyncValue;
  final String Function(T data) textBuilder;
  final String backgroundImageAssetPath;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            backgroundImageAssetPath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: height.h,
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 0.8],
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
            ),
          ),
          asyncValue.when(
            data: (data) {
              return Padding(
                padding: EdgeInsets.all(10.0.r),
                child: Text(
                  textBuilder(data),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              );
            },
            error: (e, _) => Text(e.toString()),
            loading: () => const PrayerShimmer(),
          ),
        ],
      ),
    );
  }
}
