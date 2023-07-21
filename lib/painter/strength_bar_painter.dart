import 'package:flutter/material.dart';

class StrengthBarPainter extends CustomPainter {
  // Color of the strength bar
  final Color color;

  // Radius of the strength bar
  final double radius;

  // Percentage of the strength bar
  final double percentage;

  StrengthBarPainter({
    required this.color,
    required this.radius,
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintBar(canvas, size);
  }

  @override
  bool shouldRepaint(StrengthBarPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }

  void paintBar(Canvas canvas, Size size) {
    // Paint the bar
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Size of the bar
    double left = 0;
    double top = 0;
    double right = size.width / 100 * percentage;
    double bottom = size.height;

    // Draw the bar
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        left,
        top,
        right,
        bottom,
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
      paint,
    );
  }
}
