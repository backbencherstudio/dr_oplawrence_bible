import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MorningPrayerShimmer extends StatelessWidget {
  const MorningPrayerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.orangeAccent,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 15.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 15.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),

          SizedBox(height: 10.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 15.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 15.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ],
      ),
    );
  }
}
