import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedOption = StateProvider<int?>((ref) => null);

class CustomMultipleChoiceField extends ConsumerWidget {
  final TextEditingController controller;
  final List<String> options;
  const CustomMultipleChoiceField({
    super.key,
    required this.controller,
    required this.options,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedOption);
    return SizedBox(
      height: Utils.fullHeight(context) * 0.15,
      child: GridView.builder(
        itemCount: options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 3
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              controller.text = options[index];
              ref.read(selectedOption.notifier).state = index;
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (selected == index) ? ColorsManager.primaryColor : ColorsManager.textFormBorderColor.withValues(
                    alpha: 0.5,
                  ),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
                color: (selected == index) ? ColorsManager.primaryColor : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(options[index], style: getMediumStyle(color: (selected == index) ? ColorsManager.whiteColor : ColorsManager.primaryTextColor),),
                  Icon(
                    Icons.check_circle_outline,
                    color: ColorsManager.whiteColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
