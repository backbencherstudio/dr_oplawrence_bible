import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessageText extends StatelessWidget {
  const ErrorMessageText({
    super.key,
    this.message = "Something went wrong. Please try again.",
    this.onRetry,
    this.compact = false,
    this.color = const Color(0xff4A4A4A),
  });

  final String message;
  final VoidCallback? onRetry;
  final bool compact;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.merriweather(
      fontSize: compact ? 13.sp : 15.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );

    if (compact) {
      return Text(message, textAlign: TextAlign.center, style: textStyle);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline_rounded, color: color, size: 22.sp),
        SizedBox(height: 6.h),
        Text(message, textAlign: TextAlign.center, style: textStyle),
        if (onRetry != null) ...[
          SizedBox(height: 8.h),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ],
    );
  }
}
