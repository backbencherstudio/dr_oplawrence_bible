import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/reference_shimmer.dart';

class VerseReferenceRow<T> extends StatelessWidget {
  const VerseReferenceRow({
    super.key,
    required this.asyncValue,
    required this.referenceBuilder,
    this.lineAssetPath = 'assets/images/Line.png',
    this.fallbackText = 'reference',
  });

  final AsyncValue<T> asyncValue;
  final String? Function(T data) referenceBuilder;
  final String lineAssetPath;
  final String fallbackText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset(lineAssetPath, scale: 3),
        asyncValue.when(
          data: (data) => Text(
            referenceBuilder(data)?.isNotEmpty == true
                ? referenceBuilder(data)!
                : fallbackText,
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4A4A4A),
            ),
          ),
          error: (e, _) => Text("Something went worng"),
          loading: () => const ReferenceShimmer(),
        ),
        Image.asset(lineAssetPath, scale: 3),
      ],
    );
  }
}
