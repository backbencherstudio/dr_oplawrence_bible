import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xff1F3B96),
    this.labelColor = Colors.white,
  });

  /// Text shown on the button.
  final String label;

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// Background color of the button.
  final Color backgroundColor;

  /// Color of the label text.
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      onPressed: onPressed,
      child: Center(
        child: Text(label, style: TextStyle(color: labelColor)),
      ),
    );
  }
}
