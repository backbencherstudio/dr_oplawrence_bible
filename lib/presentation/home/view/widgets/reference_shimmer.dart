import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ReferenceShimmer extends StatelessWidget {
  const ReferenceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue.withOpacity(0.1),
      highlightColor: Colors.grey.shade100,
      child:   Container(
            height: 10.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
    );
  }
}
