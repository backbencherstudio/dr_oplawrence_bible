import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// Preset topic chips (Barakat, Peace, Love, Salvation, Faith).
class SearchTopicChips extends StatelessWidget {
  const SearchTopicChips({super.key, required this.onTopicTap});

  final ValueChanged<String> onTopicTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _IconChip('Barakat', 'assets/icons/barakat.svg', onTopicTap),
            SizedBox(width: 10.w),
            _IconChip('Peace', 'assets/icons/peace.svg', onTopicTap),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _IconChip('Love', 'assets/icons/love.svg', onTopicTap),
            SizedBox(width: 10.w),
            _IconChip('Salvation', 'assets/icons/Salvation.svg', onTopicTap),
            SizedBox(width: 10.w),
            _IconChip('Faith', 'assets/icons/Faith.svg', onTopicTap),
          ],
        ),
      ],
    );
  }
}

class _IconChip extends StatelessWidget {
  const _IconChip(this.label, this.iconPath, this.onTap);

  final String label;
  final String iconPath;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(fontSize: 18.sp, color: const Color(0xff1A1A1A)),
            ),
          ],
        ),
      ),
    );
  }
}