import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NumberTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool? isRequired;
  const NumberTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    final style = getApplicationTheme().textTheme;
    final screenHeight = Utils.fullHeight(context);
    return SizedBox(
      height: screenHeight * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: style.bodyMedium,
                children: [
                  TextSpan(text: "$label "),
                  TextSpan(
                    text: (isRequired ?? false) ? "*" : "",
                    style: TextStyle(color: ColorsManager.errorColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                prefix: Text("+44 |  "),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(IconManager.ukFlag),
                ),
                prefixStyle: style.bodyMedium
              ),
            ),
          ),
        ],
      ),
    );
  }
}
