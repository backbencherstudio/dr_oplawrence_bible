import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconAssetPath,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.buttonColor = const Color(0xff1F3B96),
    this.buttonLabel = 'Start',
  });

  final String title;
  final String subtitle;
  final String iconAssetPath;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color buttonColor;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          spacing: 15,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color(0xff4A4A4A),
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(iconAssetPath),
              ],
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              child: Center(child: Text(buttonLabel)),
            ),
          ],
        ),
      ),
    );
  }
}
