import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable circular back button used across screens.
class CircleBackButton extends StatelessWidget {
  const CircleBackButton({super.key, this.onTap, this.iconSize = 20});

  final VoidCallback? onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: iconSize,
          color: Colors.black,
        ),
      ),
    );
  }
}