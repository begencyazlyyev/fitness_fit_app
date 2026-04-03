import 'package:flutter/material.dart';

class WeeklyChartPainter extends CustomPainter {
  final List<int> completed;
  final List<int> total;
  final List<String> days;
  final int todayIndex;

  WeeklyChartPainter({
    required this.completed,
    required this.total,
    required this.days,
    required this.todayIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double paddingTop = 10;
    const double paddingBottom = 36;
    const double paddingLeft = 8;
    const double paddingRight = 8;

    final double chartHeight = size.height - paddingTop - paddingBottom;
    final double chartWidth = size.width - paddingLeft - paddingRight;
    final int count = days.length;
    final double stepX = chartWidth / (count - 1);

    final int maxCompleted = completed.reduce((a, b) => a > b ? a : b);
    final int maxTotal = total.reduce((a, b) => a > b ? a : b);
    final int maxVal = maxCompleted > maxTotal ? maxCompleted : maxTotal;

    // Compute dot positions
    final List<Offset> points = [];
    for (int i = 0; i < count; i++) {
      final double x = paddingLeft + i * stepX;
      final double ratio = maxVal == 0
          ? 0
          : (completed[i] / maxVal).clamp(0.0, 1.0);
      final double y = paddingTop + chartHeight * (1 - ratio);
      points.add(Offset(x, y));
    }

    // --- Horizontal baseline ---
    final Paint gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(paddingLeft, paddingTop + chartHeight),
      Offset(size.width - paddingRight, paddingTop + chartHeight),
      gridPaint,
    );

    // --- Smooth bezier line ---
    final Paint linePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Path linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      final Offset prev = points[i - 1];
      final Offset curr = points[i];
      final double cpX = (prev.dx + curr.dx) / 2;
      linePath.cubicTo(cpX, prev.dy, cpX, curr.dy, curr.dx, curr.dy);
    }
    canvas.drawPath(linePath, linePaint);

    // --- Dots ---
    final Paint dotOuterPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint dotInnerPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 6, dotOuterPaint);
      canvas.drawCircle(points[i], 4, dotInnerPaint);
      canvas.drawCircle(points[i], 1.5, dotOuterPaint);
    }

    // --- Day labels ---
    for (int i = 0; i < count; i++) {
      final bool isToday = i == todayIndex;
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: days[i],
          style: TextStyle(
            fontSize: 12,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? const Color(0xFF3B82F6) : Colors.black87,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(
          paddingLeft + i * stepX - tp.width / 2,
          size.height - paddingBottom + 10,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant WeeklyChartPainter oldDelegate) {
    return oldDelegate.completed != completed ||
        oldDelegate.total != total ||
        oldDelegate.todayIndex != todayIndex;
  }
}
