import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

// 🔹 Provider to hold the selected date
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

class CalendarTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String label;
  final bool? isRequired;
  final String? hintText;

  const CalendarTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired,
    this.hintText,
  });

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(selectedDateProvider) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  if (isRequired ?? false)
                    TextSpan(
                      text: "*",
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
              readOnly: true,
              onTap: () => _selectDate(context, ref),
              decoration: InputDecoration(
                hint: Text(hintText ?? "enter your $label", style: getSmallStyle(color: ColorsManager.secondaryTextColor.withValues(alpha: 0.5)),),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                fillColor: ColorsManager.jobCardColor,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
