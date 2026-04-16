import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class SelectionWidget extends StatefulWidget {
  final String workout;
  final int weight;
  final String type;
  final VoidCallback? arrowUp;
  final VoidCallback? arrowDown;

  const SelectionWidget({
    super.key,
    required this.workout,
    required this.weight,
    required this.type,
    this.arrowUp,
    this.arrowDown,
  });

  @override
  State<SelectionWidget> createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  Timer? _timer;

  void _startContinuous(VoidCallback? action) {
    if (action == null) return;
    action(); // fire once immediately
    _timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      action();
    });
  }

  void _stopContinuous() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.workout,
          style: KTextStyle.titleStyle.copyWith(fontSize: 18),
        ),
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
                "${widget.weight}",
                style: KTextStyle.titleStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(15),
            Text(
              widget.type,
              style: KTextStyle.fitStyle.copyWith(fontSize: 16),
            ),
            const Gap(5),
            SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -12,
                    child: GestureDetector(
                      onTap: widget.arrowUp,
                      onLongPressStart: (_) => _startContinuous(widget.arrowUp),
                      onLongPressEnd: (_) => _stopContinuous(),
                      child: const Icon(Icons.arrow_drop_up, size: 40),
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    child: GestureDetector(
                      onTap: widget.arrowDown,
                      onLongPressStart: (_) =>
                          _startContinuous(widget.arrowDown),
                      onLongPressEnd: (_) => _stopContinuous(),
                      child: const Icon(Icons.arrow_drop_down, size: 40),
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
