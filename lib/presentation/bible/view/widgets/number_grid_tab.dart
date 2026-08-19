import 'package:flutter/material.dart';

import 'number_grid_tile.dart';

class NumberGridTab extends StatelessWidget {
  const NumberGridTab({
    super.key,
    required this.numbers,
    this.selectedIndex,
    required this.onNumberTap,
  });

  final List<int> numbers;
  final int? selectedIndex;
  final ValueChanged<int> onNumberTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return NumberGridTile(
          number: numbers[index],
          selected: selectedIndex == index,
          onTap: () => onNumberTap(index),
        );
      },
    );
  }
}

