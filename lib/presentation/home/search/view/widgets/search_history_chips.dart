import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Wraps the saved search history as tappable, removable chips.
class SearchHistoryChips extends StatelessWidget {
  const SearchHistoryChips({
    super.key,
    required this.items,
    required this.onTap,
    required this.onRemove,
  });

  final List<String> items;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text("No history yet", style: TextStyle(color: Colors.grey));
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((item) {
        return GestureDetector(
          onTap: () => onTap(item),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => onRemove(item),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}