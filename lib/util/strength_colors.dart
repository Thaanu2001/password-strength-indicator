part of '../password_strength_indicator.dart';

class StrengthColors {
  // Colors for the strength bar

  // Color of weak strength
  final Color weak;

  // Color of medium strength
  final Color medium;

  // Color of strong strength
  final Color strong;

  const StrengthColors({
    this.weak = Colors.red,
    this.medium = Colors.yellow,
    this.strong = Colors.green,
  });

  // Returns the color of the strength bar based on the strength
  Color getColor(double strength) {
    if (strength < 1 / 3) {
      return weak;
    } else if (strength < 2 / 3) {
      return medium;
    } else {
      return strong;
    }
  }
}
