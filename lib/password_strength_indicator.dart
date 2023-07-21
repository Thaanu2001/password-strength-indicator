library password_strength_indicator;

import 'package:flutter/material.dart';
import 'dart:math';

part 'painter/strength_bar_background_painter.dart';
part 'painter/strength_bar_dashed_painter.dart';
part 'painter/strength_bar_painter.dart';
part 'password_strength/password_strength.dart';
part 'util/strength_bar_style.dart';
part 'util/strength_colors.dart';
part 'password_strength/src/bruteforce.dart';
part 'password_strength/src/common.dart';

/// Password strength indicator widget for Flutter applications.
/// It estimates the strength of the password and displays it in a strength bar.
/// It also provides a callback to get the strength of the password.
/// It can be customized by changing the width, thickness, background color,
/// radius, colors, duration, and curve.
/// The strength bar is drawn using the [CustomPaint] widget.
/// The strength bar is drawn using the [StrengthBarPainter] widget.
/// The background of the strength bar is drawn using
/// the [StrengthBarBackgroundPainter] widget.
/// The strength of the password is estimated using the [estimatePasswordStrength] function.
class PasswordStrengthIndicator extends StatefulWidget {
  final String? password;

  // Width of the strength bar
  final double? width;

  // Thickness of the strength bar
  final double thickness;

  // Background color of the strength bar
  final Color backgroundColor;

  // Radius of the strength bar
  final double radius;

  // Colors of the strength bar
  final StrengthColors colors;

  // Duration of the animation
  final Duration? duration;

  // Curve of the animation
  final Curve curve;

  // Strength callback
  final void Function(double strength)? callback;

  // Strength builder
  final double Function(String password)? strengthBuilder;

  // Style of the strength bar
  final StrengthBarStyle style;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.width,
    this.thickness = 8.0,
    this.backgroundColor = const Color.fromARGB(255, 217, 217, 217),
    this.radius = 5.0,
    this.colors = const StrengthColors(),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.callback,
    this.strengthBuilder,
    this.style = StrengthBarStyle.line,
  });

  @override
  State<PasswordStrengthIndicator> createState() =>
      _PasswordStrengthIndicatorState();
}

class _PasswordStrengthIndicatorState extends State<PasswordStrengthIndicator>
    with SingleTickerProviderStateMixin {
  // Animation controller of the strength bar
  late AnimationController _animationController;

  // Animation of the strength bar
  late Animation<double> _animation;

  // Strength of the password
  late double _strength;

  // Width of the strength bar
  late double? _width;

  // Thickness of the strength bar
  late double _thickness;

  // Background color of the strength bar
  late Color _backgroundColor;

  // Radius of the strength bar
  late double _radius;

  // Colors of the strength bar
  late StrengthColors _colors;

  // Strength callback
  void Function(double strength)? _callback;

  // Strength builder
  double Function(String password)? _strengthBuilder;

  // begin of the animation
  late double _begin = 0.0;

  // end of the animation
  late double _end = 0.0;

  // Active color of the strength bar
  late Color _activeColor;

  // Strength bar style
  late StrengthBarStyle _style;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Initialize the animation
    _animation = Tween<double>(
      begin: _begin,
      end: _begin,
    ).animate(_animationController);

    // Initialize the strength
    _strength = 0.0;

    // Initialize the width
    _width = widget.width;

    // Initialize the thickness
    _thickness = widget.thickness;

    // Initialize the background color
    _backgroundColor = widget.backgroundColor;

    // Initialize the radius
    _radius = widget.radius;

    // Initialize the colors
    _colors = widget.colors;

    // Initialize the callback
    _callback = widget.callback;

    // Initialize the strength builder
    _strengthBuilder = widget.strengthBuilder;

    // Initialize the active color
    _activeColor = _colors.getColor(_strength);

    // Initialize the style
    _style = widget.style;

    // Start the animation
    _animationController.forward();
  }

  void animate() {
    // Calculate the strength
    _strength = _strengthBuilder != null
        ? _strengthBuilder!(widget.password ?? '')
        : estimatePasswordStrength(widget.password ?? '');

    _begin = _end;
    _end = _strength * 100;

    // Calculate the active color
    _activeColor = _colors.getColor(_strength);

    // Update the animation
    _animation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );

    // Start the animation
    _animationController.forward(from: 0);

    // Call the callback
    _callback?.call(_strength);
  }

  @override
  void didUpdateWidget(covariant PasswordStrengthIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.password != widget.password) {
      animate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StrengthBar(
      animation: _animation,
      width: _width,
      thickness: _thickness,
      backgroundColor: _backgroundColor,
      radius: _radius,
      colors: _colors,
      activeColor: _activeColor,
      style: _style,
    );
  }
}

class StrengthBar extends AnimatedWidget {
  // Width of the strength bar
  final double? width;

  // Thickness of the strength bar
  final double thickness;

  // Background color of the strength bar
  final Color backgroundColor;

  // Radius of the strength bar
  final double radius;

  // Colors of the strength bar
  final StrengthColors colors;

  // Active color of the strength bar
  final Color activeColor;

  // Style of the strength bar
  final StrengthBarStyle style;

  const StrengthBar({
    Key? key,
    required Animation<double> animation,
    required this.width,
    required this.thickness,
    required this.backgroundColor,
    required this.radius,
    required this.colors,
    required this.activeColor,
    required this.style,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (style) {
          case StrengthBarStyle.line:
            return CustomPaint(
              size: Size(width ?? constraints.maxWidth, thickness),
              painter: StrengthBarBackgroundPainter(
                color: backgroundColor,
                radius: radius,
              ),
              foregroundPainter: StrengthBarPainter(
                color: activeColor,
                radius: radius,
                percentage: (listenable as Animation<double>).value,
              ),
            );
          case StrengthBarStyle.dashed:
            return Row(
              children: [
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.weak,
                      radius: radius,
                      dashCount: 1,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.medium,
                      radius: radius,
                      dashCount: 2,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomPaint(
                    size: Size(width ?? constraints.maxWidth, thickness),
                    painter: StrengthBarBackgroundPainter(
                      color: backgroundColor,
                      radius: radius,
                    ),
                    foregroundPainter: StrengthBarDashedBarPainter(
                      color: colors.strong,
                      radius: radius,
                      dashCount: 3,
                      percentage: (listenable as Animation<double>).value,
                    ),
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
