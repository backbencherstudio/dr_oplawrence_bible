import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final checkBoxProvider = StateProvider<bool>((ref) => false);

class CustomCheckbox extends ConsumerWidget {
  final String? label;
  final TextEditingController? controller;

  const CustomCheckbox({
    super.key,
    this.label,
    required this.controller
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkBoxProvider);
    
    return InkWell(
      onTap: () {
        ref.read(checkBoxProvider.notifier).state = !isChecked;
        controller?.text = (!isChecked).toString();
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isChecked
                    ? (ColorsManager.primaryColor)
                    : (Colors.grey.shade600),
                width: 1,
              ),
              color: isChecked
                  ? (ColorsManager.primaryColor)
                  : Colors.transparent,
            ),
            child: isChecked
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.bold,
                  )
                : null,
          ),
          if (label != null) ...[
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label ?? "",
                style: getMediumStyle(color: ColorsManager.secondaryTextColor),
                maxLines: null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
