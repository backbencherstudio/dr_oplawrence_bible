import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingItem extends StatelessWidget {
  final String svg;
  final String itemName;
  final void Function()? onTap;
  const SettingItem({super.key, required this.svg, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utils.fullHeight(context)*0.05,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(svg, colorFilter: ColorFilter.mode(ColorsManager.primaryColor, BlendMode.srcIn),),
            SizedBox(width: 8),
            Text(itemName, style: getExtraMediumStyle(),),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}