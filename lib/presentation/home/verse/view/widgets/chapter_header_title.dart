import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterHeaderTitle extends StatelessWidget {
  const ChapterHeaderTitle({
    super.key,
    required this.bookName,
    required this.chapterNumber,
  });

  final String bookName;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Text(
        "$bookName $chapterNumber",
        style: TextStyle(
          color: const Color(0xFFB71C1C),
          fontSize: 26.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia',
        ),
      ),
    );
  }
}
