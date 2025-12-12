import 'package:flutter/material.dart';

class DottedDivider extends StatefulWidget {
  final double height;
  final double dotWidth;
  final double spacing;
  final Color color;

  const DottedDivider({
    super.key,
    this.height = 1,
    this.dotWidth = 6,
    this.spacing = 4,
    this.color = Colors.grey,
  });

  @override
  State<DottedDivider> createState() => _DottedDividerState();
}

class _DottedDividerState extends State<DottedDivider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dots = (constraints.maxWidth / (widget.dotWidth + widget.spacing)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dots,
                (_) => Container(
              width: widget.dotWidth,
              height: widget.height,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
