import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ButtonWidget({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
