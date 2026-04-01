import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const PhoneFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
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
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            floatingLabelStyle: const TextStyle(color: Colors.black),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
            prefix: const Text(
              "+993 ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.2,
                color: Color(0xFF36454F),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
