import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.paddingTop = 20.0,
    this.paddingLeft = 20.0,
    this.paddingRight = 20.0,
    this.paddingBottom = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        right: paddingRight,
        bottom: paddingBottom,
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          backgroundColor: Color(0xFF1C2A3A),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
