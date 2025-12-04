import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final double rating; 
  final int starCount;
  final double size;
  final Color color;
  final Color borderColor;

  const StarDisplay({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 24,
    this.color = Colors.amber,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        IconData icon;
        if (index >= rating) {
          icon = Icons.star_border;
        } else if (index > rating - 1 && index < rating) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star;
        }

        return Icon(
          icon,
          color: icon == Icons.star_border ? borderColor : color,
          size: size,
        );
      }),
    );
  }
}
