import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';

class AppbarSection02 extends StatelessWidget {
  final String? title;
  final bool? isPostShift;
  const AppbarSection02({super.key, this.title, this.isPostShift});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        if (title != null) ...[Text(title ?? "N/A", style: getExtraMediumStyle(fontWeight: FontWeight.w500))],
        if (isPostShift ?? false) ...[
          InkWell(
            onTap: () {
              // LOGIC
            },
            child: Text(
              "Post New Shift",
              style: getMediumStyle(color: ColorsManager.primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ] else ...[
          SizedBox(),
        ],
      ],
    );
  }
}
