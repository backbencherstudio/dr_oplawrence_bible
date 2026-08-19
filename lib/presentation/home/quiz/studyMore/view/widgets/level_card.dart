import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable card representing a study/quiz level, locked or unlocked.
class LevelCard extends StatelessWidget {
  const LevelCard({
    super.key,
    required this.levelName,
    required this.isUnlocked,
    required this.onStart,
  });

  final String levelName;
  final bool isUnlocked;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final accentColor = isUnlocked ? const Color(0xffCDA434) : Colors.grey;

    return GestureDetector(
      onTap: isUnlocked ? onStart : null,
      child: Container(
        padding: EdgeInsets.all(16.0.w),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.0.r),
          border: Border(
            left: BorderSide(color: accentColor, width: 8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              levelName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? Colors.black : Colors.grey.shade600,
              ),
            ),
            OutlinedButton(
              onPressed: isUnlocked ? onStart : () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                side: BorderSide(color: accentColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}