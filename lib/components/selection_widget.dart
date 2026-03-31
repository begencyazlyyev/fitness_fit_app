import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class SelectionWidget extends StatelessWidget {
  final String workout;
  final int weight;
  final String type;
  final VoidCallback arrowUp;
  final VoidCallback arrowDown;

  const SelectionWidget({
    super.key,
    required this.workout,
    required this.weight,
    required this.type,
    required this.arrowUp,
    required this.arrowDown,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment
          .center, // Aligns "When lifting" with the right side
      children: [
        Text(workout, style: KTextStyle.titleStyle.copyWith(fontSize: 18)),
        // Specifics
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$weight",
                style: KTextStyle.titleStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(15),
            Text(type, style: KTextStyle.fitStyle.copyWith(fontSize: 16)),
            const Gap(5),
            SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -10, // pull up slightly
                    child: GestureDetector(
                      onTap: arrowUp, // First function
                      child: Icon(Icons.arrow_drop_up, size: 40),
                    ),
                  ),
                  Positioned(
                    bottom: -10, // pull down slightly
                    child: GestureDetector(
                      onTap: arrowDown,
                      child: Icon(Icons.arrow_drop_down, size: 40),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
