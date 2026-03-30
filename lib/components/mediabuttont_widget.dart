// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Widget mediaButton(
  String text, {
  required bool isActive,
  required bool isLeft,
}) {
  return AnimatedContainer(
    // Use AnimatedContainer for smoother transitions
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    decoration: BoxDecoration(
      color: isActive ? Color(0xFFE9ECF3) : Colors.transparent,
      borderRadius: BorderRadius.horizontal(
        left: isLeft ? const Radius.circular(15) : Radius.zero,
        right: !isLeft ? const Radius.circular(15) : Radius.zero,
      ),
      boxShadow: isActive
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ]
          : [],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: isActive ? Colors.black : Colors.white,
      ),
    ),
  );
}
