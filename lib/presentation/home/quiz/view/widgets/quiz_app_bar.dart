import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable quiz app bar with back button, title and school action icon.
class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizAppBar({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffEBEBEB),
      elevation: 0,
      leading: GestureDetector(
        onTap: onBack ?? () => Navigator.maybePop(context),
        child: Image.asset('assets/icons/back_arrow.png', scale: 4),
      ),
      title: Text(
        'Quiz',
        style: GoogleFonts.merriweather(
          color: const Color(0xFFC70039),
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0.w),
          child: Icon(Icons.school, color: Colors.black),
        ),
      ],
    );
  }
}