import 'dart:developer';
import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';

final obscureProvider = StateProvider.family<bool, String>((ref, label) => false);

class PrimaryTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool? isRequired;
  final bool? isPass;
  final bool? isNumber;
  final bool? isDescription; 
  final String? icon;
  const PrimaryTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.isRequired,
    this.isPass,
    this.isNumber,
    this.icon,
    this.isDescription
  });

  @override
  Widget build(BuildContext context) {
    final style = getApplicationTheme().textTheme;
    final screenHeight = Utils.fullHeight(context);
    return SizedBox(
      height: (isDescription ?? false) ? screenHeight * 0.18 : screenHeight * 0.1,
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
          Consumer(
            builder: (_, ref, _) {
              final isObscure = ref.watch(obscureProvider(label));
              return TextFormField(
                maxLines: (isDescription ?? false) ? 5 : 1,
                keyboardType: (isNumber ?? false) ? TextInputType.number : TextInputType.text,
                controller: controller,
                obscureText: (isPass ?? false) ? !isObscure : isObscure,
                decoration: InputDecoration(
                  fillColor: ColorsManager.jobCardColor,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hint: Text(hintText ?? "enter your $label", style: getSmallStyle(color: ColorsManager.secondaryTextColor.withValues(alpha: 0.5)),),
                  suffixIcon: (isPass ?? false) ? InkWell(child: Padding(
                    padding: EdgeInsets.all(14),
                    child: SvgPicture.asset(!isObscure ? IconManager.eyeClose : IconManager.eyeOpen),
                  ), onTap: (){
                    ref.read(obscureProvider(label).notifier).state = !isObscure;
                    log("Obscure Tapped: $isObscure");
                  },) : (icon != null) ? Padding(
                    padding: EdgeInsets.all(14),
                    child: SvgPicture.asset(icon ?? IconManager.cancel01),
                  ) : null,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
