// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class GenderDropdownWidget extends StatefulWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GenderDropdownWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<GenderDropdownWidget> createState() => _GenderDropdownWidgetState();
}

class _GenderDropdownWidgetState extends State<GenderDropdownWidget> {
  void _openGenderPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Select Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _GenderOption(
                icon: Icons.male,
                label: "Male",
                isSelected: widget.value == "Male",
                onTap: () {
                  widget.onChanged("Male");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _GenderOption(
                icon: Icons.female,
                label: "Female",
                isSelected: widget.value == "Female",
                onTap: () {
                  widget.onChanged("Female");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: _openGenderPicker,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade50,
            border: Border.all(width: 1.2, color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.person_outline, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                widget.value ?? "Gender",
                style: TextStyle(
                  color: widget.value != null ? Colors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? const Color(0xFF36454F).withOpacity(0.1)
              : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? const Color(0xFF36454F) : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF36454F) : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF36454F) : Colors.black,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF36454F),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
