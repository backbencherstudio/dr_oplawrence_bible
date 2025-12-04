import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertContainer extends StatelessWidget {
  final String? title;
  final String description;
  final String? svgIcon;
  final bool? isNoWarning;
  final Color? bgColor;
  final Color? textColor;
  const AlertContainer({
    super.key,
    required this.description,
    this.title,
    this.svgIcon,
    this.isNoWarning,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = getApplicationTheme().textTheme;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor ?? ColorsManager.warningColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNoWarning ?? false)
              ...[
                SvgPicture.asset(
                  svgIcon ?? IconManager.alertTriangle,
                  width: 24,
                  height: 24,
                ),
              ],
              if (title != null) ...[
                Text(
                  title!,
                  style: style.bodySmall?.copyWith(
                    color: textColor ?? ColorsManager.orangeTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          RichText(
            text: TextSpan(
              style: style.bodySmall?.copyWith(
                color: textColor ?? ColorsManager.orangeTextColor,
              ),
              children: [TextSpan(text: description)],
            ),
          ),
        ],
      ),
    );
  }
}
