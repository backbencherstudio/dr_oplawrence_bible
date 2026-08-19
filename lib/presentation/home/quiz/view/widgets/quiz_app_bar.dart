import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable quiz app bar with back button, title and optional action icon.
class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizAppBar({
    super.key,
    this.title = 'Quiz',
    this.onBack,
    this.action,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? action;

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
        title,
        style: GoogleFonts.merriweather(
          color: const Color(0xFFC70039),
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: true,
      actions: action == null
          ? null
          : [
              Padding(
                padding: EdgeInsets.only(right: 16.0.w),
                child: action,
              ),
            ],
    );
  }
}