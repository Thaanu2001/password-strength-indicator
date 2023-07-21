part of '../password_strength_indicator.dart';

class StrengthBarDashedBarPainter extends CustomPainter {
  // Color of the strength bar
  final Color color;

  // Radius of the strength bar
  final double radius;

  // Percentage of the strength bar
  final double percentage;

  // Dash count of the strength bar
  final int dashCount;

  StrengthBarDashedBarPainter({
    required this.color,
    required this.radius,
    required this.percentage,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintBar(canvas, size);
  }

  @override
  bool shouldRepaint(StrengthBarDashedBarPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }

  void paintBar(Canvas canvas, Size size) {
    late double percentage = this.percentage;
    
    // Calculate the percentage based on the dash count
    if (dashCount == 1) {
      if (percentage > (100 * 1 / 3)) {
        percentage = 100;
      } else {
        percentage = (percentage / (100 * 1 / 3)) * 100;
      }
    } else if (dashCount == 2) {
      if (percentage > (100 * 2 / 3)) {
        percentage = 100;
      } else if (percentage < (100 * 1 / 3)) {
        percentage = 0;
      } else {
        percentage = ((percentage - (100 * 1 / 3)) / (100 * 1 / 3)) * 100;
      }
    } else if (dashCount == 3) {
      if (percentage > (100 * 3 / 3)) {
        percentage = 100;
      } else if (percentage < (100 * 2 / 3)) {
        percentage = 0;
      } else {
        percentage = ((percentage - (100 * 2 / 3)) / (100 * 1 / 3)) * 100;
      }
    }

    // Paint the bar
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    // Size of the bar
    double left = 0;
    double top = 0;
    double right = size.width / 100 * percentage;
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
