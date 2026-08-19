import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.width = 100,
    this.labelFontSize = 16,
  });

  /// Icon widget shown above the label (SvgPicture.asset, Image.asset, etc).
  final Widget icon;

  /// Text shown under the icon.
  final String label;

  /// Called when the button is tapped.
  final VoidCallback onTap;

  /// Width of the button container.
  final double width;

  /// Font size for the label text.
  final double labelFontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            spacing: 5,
            children: [
              icon,
              Text(
                label,
                style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.w400,
                  fontSize: labelFontSize.sp,
                  color: const Color(0xff1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
