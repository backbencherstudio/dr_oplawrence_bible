import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NavRowButton extends StatelessWidget {
  const NavRowButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(
                label,
                style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
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
