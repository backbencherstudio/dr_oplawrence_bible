import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable top bar for the quiz: back button, question counter and progress.
class QuizTopBar extends StatelessWidget {
  const QuizTopBar({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.onBackTap,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : (currentIndex + 1) / total;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBackTap,
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        SizedBox(width: 16.w),

        Expanded(
          child: Column(
            children: [
              Text(
                "${currentIndex + 1}/$total",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 6.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.h,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 16.w),

        Image.asset('assets/icons/slider.png', scale: 3),
      ],
    );
  }
}