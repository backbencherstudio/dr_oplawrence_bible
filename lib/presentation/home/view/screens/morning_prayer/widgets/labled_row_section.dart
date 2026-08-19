import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/prayer_shimmer.dart';

class LabeledVerseSection<T> extends StatelessWidget {
  const LabeledVerseSection({
    super.key,
    required this.title,
    required this.asyncValue,
    required this.textBuilder,
  });

  final String title;
  final AsyncValue<T> asyncValue;
  final String Function(T data) textBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.w,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.merriweather(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff1A1A1A),
          ),
        ),
        asyncValue.when(
          data: (data) => Text(
            textBuilder(data),
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4A4A4A),
              height: 1.4.h,
              letterSpacing: 0.6.w,
              wordSpacing: 2.0.w,
            ),
          ),
          error: (e, _) => Text("Something went wrong"),
          loading: () => const PrayerShimmer(),
        ),
      ],
    );
  }
}
