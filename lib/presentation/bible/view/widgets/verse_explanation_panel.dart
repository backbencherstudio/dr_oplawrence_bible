import 'package:dr_oplawrence_bible/data/models/bible_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable card showing an AI explanation for a verse.
class VerseExplanationPanel extends StatelessWidget {
  const VerseExplanationPanel({
    super.key,
    required this.explanation,
    required this.onClose,
  });

  final BibleAiExplanationModel? explanation;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (explanation == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Stack(
        children: [
          Container(
            width: double.infinity.w,
            padding: EdgeInsets.all(13.r),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 22, 94, 24),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Explanation:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  explanation!.explanation ?? "",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 22, 94, 24),
                    fontSize: 16.sp,
                    fontFamily: 'Georgia',
                  ),
                ),
              ],
            ),
          ),
          // ===== Close Button =====
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                padding: EdgeInsets.all(4.w),
                child: const Icon(
                  Icons.cancel_rounded,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}