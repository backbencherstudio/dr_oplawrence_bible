import 'package:flutter/material.dart';
import 'word_chip.dart';

class WordChipData {
  const WordChipData({required this.iconAssetPath, required this.label});

  final String iconAssetPath;
  final String label;
}

class WordChipWrap extends StatelessWidget {
  const WordChipWrap({
    super.key,
    required this.chips,
    this.spacing = 10,
    this.runSpacing = 10,
  });

  final List<WordChipData> chips;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // alignment: WrapAlignment.center,
      // direction: Axis.horizontal,
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        for (final chip in chips)
          WordChip(iconAssetPath: chip.iconAssetPath, label: chip.label),
      ],
    );
  }
}
