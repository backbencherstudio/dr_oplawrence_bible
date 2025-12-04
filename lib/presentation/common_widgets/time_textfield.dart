import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

// 🔹 Provider to hold the selected time
final selectedTimeProvider = StateProvider<TimeOfDay?>((ref) => null);

class TimeTextfield extends ConsumerWidget {
  final TextEditingController controller;
  final String label;
  final bool? isRequired;
  final String? hintText;

  const TimeTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired,
    this.hintText,
  });

  Future<void> _selectTime(BuildContext context, WidgetRef ref) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: ref.read(selectedTimeProvider) ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(selectedTimeProvider.notifier).state = picked;

      // Format the time to HH:mm
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute),
      );
      controller.text = formattedTime;
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
              onTap: () => _selectTime(context, ref),
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.access_time_outlined),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
