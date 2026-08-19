import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/search_model.dart';

/// Non-scrolling list of verse result cards with reference badges.
class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key, required this.verses});

  final List<VerseData> verses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: verses.length,
      itemBuilder: (context, index) {
        final verse = verses[index];

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  verse.text ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    height: 1.5.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffB02626),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      verse.reference ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}