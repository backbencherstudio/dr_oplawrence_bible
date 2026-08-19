import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WordChip extends StatelessWidget {
  const WordChip({super.key, required this.iconAssetPath, required this.label});

  final String iconAssetPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconAssetPath),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: const Color(0xff1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
