import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final starProvider = StateProvider<int>((ref)=>0);

class StarField extends ConsumerWidget {
  final TextEditingController controller;
  const StarField({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStar = ref.watch(starProvider);
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isSelected = index < selectedStar;

        return GestureDetector(
          onTap: () {
            ref.read(starProvider.notifier).state = index + 1;
            controller.text = (ref.watch(starProvider)).toString();
            log("Star: ${controller.text}");
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isSelected ? 1.2 : 1.0,
            child: Icon(
              Icons.star,
              size: 40,
              color: isSelected ? const Color(0xffFFA502) : Colors.grey[400],
            ),
          ),
        );
      }),
    );
  }
}
 