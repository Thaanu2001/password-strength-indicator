part of '../password_strength_indicator.dart';

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
      ..style = PaintingStyle.fill;

    // Size of the bar
    double left = 0;
    double top = 0;
    double right = size.width / 100 * (percentage >= 100 ? 100 : percentage);
    double bottom = size.height;

    if (radius != 0 && right > 0 && radius * 2 > right) {
      right = radius * 2;
    }

    // Draw the bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom),
        Radius.circular(radius),
      ),
      paint,
    );
  }
}
