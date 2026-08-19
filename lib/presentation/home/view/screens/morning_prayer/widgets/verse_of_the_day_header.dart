import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/widgets/error_message_text.dart';
import '../../../widgets/morningshimmer.dart';
import 'verse_reference_row.dart';

class VerseOfTheDayHeader<T> extends StatelessWidget {
  const VerseOfTheDayHeader({
    super.key,
    required this.asyncValue,
    required this.referenceBuilder,
    required this.verseTextBuilder,
    this.backgroundImageAssetPath = 'assets/images/morning_background.png',
    this.backButtonAssetPath = 'assets/images/cross.png',
    this.title = 'Verse of the day',
    this.onBack,
  });

  final AsyncValue<T> asyncValue;
  final String? Function(T data) referenceBuilder;
  final String Function(T data) verseTextBuilder;
  final String backgroundImageAssetPath;
  final String backButtonAssetPath;
  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(backgroundImageAssetPath),
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
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: Image.asset(backButtonAssetPath, scale: 3),
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff1A1A1A),
                ),
              ),
              VerseReferenceRow<T>(
                asyncValue: asyncValue,
                referenceBuilder: referenceBuilder,
              ),
              asyncValue.when(
                data: (data) => Text(
                  verseTextBuilder(data),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffF7F5EF),
                  ),
                ),
                error: (_, __) => ErrorMessageText(
                  message: "Couldn't load today's verse.",
                  color: const Color(0xffF7F5EF),
                ),
                loading: () => const MorningPrayerShimmer(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
