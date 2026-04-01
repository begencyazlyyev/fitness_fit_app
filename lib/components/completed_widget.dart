import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class CompletedWidget extends StatelessWidget {
  final String workout;
  final int weight;
  final String type;

  const CompletedWidget({
    super.key,
    required this.workout,
    required this.weight,
    required this.type,
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
                color: Colors.transparent,
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
          ],
        ),
      ],
    );
  }
}
