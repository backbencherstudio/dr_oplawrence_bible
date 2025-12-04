import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final toggleSwitch = StateProvider.family<bool, String>((ref, label)=>false);

class CustomSwitch extends ConsumerWidget {
  final String label;
  final TextEditingController controller;
  const CustomSwitch({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggle = ref.watch(toggleSwitch(label));
    return Switch(
          value: toggle,
          onChanged: (value) {
            ref.read(toggleSwitch(label).notifier).state = value;
            controller.text = value.toString();
            log("$label: $value");
          },
        );
  }
}