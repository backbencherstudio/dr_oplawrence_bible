import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberGridTile extends StatelessWidget {
  const NumberGridTile({
    super.key,
    required this.number,
    this.selected = false,
    this.onTap,
  });

  final int number;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? ColorsManager.deepAmber : ColorsManager.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected
                ? ColorsManager.whiteColor
                : ColorsManager.blackColor,
          ),
        ),
      ),
    );
  }
}

