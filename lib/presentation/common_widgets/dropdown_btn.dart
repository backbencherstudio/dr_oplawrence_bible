import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';

class DropdownBtn extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController controller;

  final List<String> items;
  // Put Different value
  final String? selectedValue;
  final bool? isRequired;

  final String? Function(String?)? validator;

  const DropdownBtn({
    super.key,
    this.label,
    required this.items,
    this.hintText,
    this.selectedValue,
    this.validator,
    required this.controller,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: style.bodyMedium,
              children: [
                if(label != null) ...[
                  TextSpan(text: "$label "),
                ],
                TextSpan(
                  text: (isRequired ?? false) ? "*" : "",
                  style: TextStyle(color: ColorsManager.errorColor),
                ),
              ],
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: items.contains(selectedValue) ? selectedValue : null,
          isExpanded: true,
          dropdownColor: ColorsManager.textFormFillColor,
          decoration: InputDecoration(
            fillColor: ColorsManager.jobCardColor,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hint: Text(
              hintText ?? "enter your $label",
              style: getSmallStyle(
                color: ColorsManager.secondaryTextColor.withValues(
                  alpha: 0.5,
                ),
              ),
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: ColorsManager.primaryTextColor,
            ),
          ),
          items: items.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: style.bodyMedium),
            );
          }).toList(),
          onChanged: (value) {
            controller.text = value!;
          },
          validator: validator,
        ),
      ],
    );
  }
}
