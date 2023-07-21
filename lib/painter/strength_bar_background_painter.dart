import 'package:flutter/material.dart';

class StrengthBarBackgroundPainter extends CustomPainter {
  // Background color of the strength bar
  final Color color;

  // Radius of the strength bar
  final double radius;

  StrengthBarBackgroundPainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintBar(canvas, size);
  }

  @override
  bool shouldRepaint(StrengthBarBackgroundPainter oldDelegate) {
    return true;
  }

  void paintBar(Canvas canvas, Size size) {
    // Paint the background
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Size of the background
    double left = 0;
    double top = 0;
    double right = size.width;
    double bottom = size.height;

    // Draw the background
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
