import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryBtn extends StatelessWidget {
  final String text;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? isBig;
  final IconData? postIcon;
  final IconData? preIcon;
  final String? preSvg;
  final String? postSvg;
  final void Function()? onTap;
  const PrimaryBtn({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.borderColor,
    this.isBig,
    this.postIcon,
    this.preIcon,
    this.onTap,
    this.preSvg,
    this.postSvg,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.fullWidth(context);
    final style = getApplicationTheme().textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        width: (isBig ?? false) ? screenWidth * 0.9 : (width != null) ? width : screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Colors.transparent,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: (preIcon != null || preSvg != null || postIcon != null || postSvg != null) ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(preIcon != null) ...[Icon(preIcon, color: borderColor ?? ColorsManager.whiteColor,)],
            if(preSvg != null) ...[SvgPicture.asset(preSvg!, colorFilter: ColorFilter.mode(borderColor ?? ColorsManager.whiteColor, BlendMode.srcIn),)],
            Text(
              text,
              style: style.titleMedium?.copyWith(color: textColor ?? ColorsManager.whiteColor),
            ),
            SizedBox(width: 8),
            if(postIcon != null) ...[Icon(postIcon, color: borderColor ?? ColorsManager.whiteColor,)],
            if(postSvg != null) ...[SvgPicture.asset(postSvg!, colorFilter: ColorFilter.mode(borderColor ?? ColorsManager.whiteColor, BlendMode.srcIn),)],
          ],
        ) : Text(
          text,
          style: style.titleMedium?.copyWith(color: textColor ?? ColorsManager.whiteColor),
        ),
      ),
    );
  }
}
