import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final IconData icons;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.icons,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade50,
        ),

        height: 48,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(icons),
            prefixIconColor: Colors.grey,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: Color(0xFF36454F)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
