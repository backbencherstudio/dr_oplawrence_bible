import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';

final StateProvider<String> searchQueryProvider = StateProvider<String>((ref) => '');


class CommonSearchBar extends ConsumerWidget {
  const CommonSearchBar({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (controller == null) ? AbsorbPointer(
      child: TextFormField(
        onChanged: (val) {
          ref.read(searchQueryProvider.notifier).state = val;
        },
        controller: controller ?? TextEditingController(),
        style: getExtraMediumStyle(),
        decoration: InputDecoration(
          alignLabelWithHint: false,
          hintStyle: getExtraMediumStyle(color: ColorsManager.secondaryTextColor),
          prefixIcon: Padding(
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
              IconManager.search,
              height: 24,
            ),
          ),
          // suffixIcon: Padding(
          //   padding: EdgeInsets.all(15.r),
          //   child: SvgPicture.asset(
          //     IconManager.filter,
          //     height: 24.h,
          //   ),
          // ),
          prefixIconColor: ColorsManager.secondaryTextColor,
          hintText: 'Start typing',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          )
        ),
        
      ),
    ) : TextFormField(
        onChanged: (val) {
          ref.read(searchQueryProvider.notifier).state = val;
        },
        controller: controller ?? TextEditingController(),
        style: getExtraMediumStyle(),
        decoration: InputDecoration(
          alignLabelWithHint: false,
          hintStyle: getExtraMediumStyle(color: ColorsManager.secondaryTextColor),
          prefixIcon: Padding(
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
              IconManager.search,
              height: 24,
            ),
          ),
          // suffixIcon: Padding(
          //   padding: EdgeInsets.all(15.r),
          //   child: SvgPicture.asset(
          //     IconManager.filter,
          //     height: 24.h,
          //   ),
          // ),
          prefixIconColor: ColorsManager.secondaryTextColor,
          hintText: 'Start typing',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          )
        ),
        
      );
  }
}
