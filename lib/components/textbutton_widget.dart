import 'package:flutter/material.dart';

Widget textbuttonWidget(VoidCallback onPress, String label) {
  return Center(
    child: TextButton(
      onPressed: onPress,
      child: Text(label, style: TextStyle(fontSize: 16)),
    ),
  );
}
