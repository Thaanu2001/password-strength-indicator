library password_strength_checker;

import 'package:flutter/material.dart';

import 'painter/strength_bar_background_painter.dart';
import 'painter/strength_bar_painter.dart';
import 'password_strength/password_strength.dart';
import 'util/strength_colors.dart';

class PasswordStrengthChecker extends StatefulWidget {
  final String? password;

  // Width of the strength bar
  final double width;

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

  const PasswordStrengthChecker({
    super.key,
    required this.password,
    this.width = double.infinity,
    this.thickness = 5.0,
    this.backgroundColor = Colors.grey,
    this.radius = 5.0,
    this.colors = const StrengthColors(),
    this.duration,
    this.curve = Curves.easeInOut,
    this.callback,
  });

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker>
    with SingleTickerProviderStateMixin {
  // Animation controller of the strength bar
  late AnimationController _animationController;

  // Animation of the strength bar
  late Animation<double> _animation;

  // Strength of the password
  late double _strength;

  // Width of the strength bar
  late double _width;

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

  // begin of the animation
  late double _begin = 0.0;

  // end of the animation
  late double _end = 0.0;

  // Active color of the strength bar
  late Color _activeColor;

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

    // Initialize the active color
    _activeColor = _colors.getColor(_strength);

    // Start the animation
    _animationController.forward();
  }

  void animate() {
    // Calculate the strength
    _strength = estimatePasswordStrength(widget.password ?? '');

    _begin = 0.0;
    _end = _strength * _width;

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
    _animationController.forward(from: 0.0);

    // Call the callback
    _callback?.call(_strength);
  }

  @override
  void didUpdateWidget(covariant PasswordStrengthChecker oldWidget) {
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
      activeColor: _activeColor,
    );
  }
}

class StrengthBar extends AnimatedWidget {
  // Width of the strength bar
  final double width;

  // Thickness of the strength bar
  final double thickness;

  // Background color of the strength bar
  final Color backgroundColor;

  // Radius of the strength bar
  final double radius;

  // Active color of the strength bar
  final Color activeColor;

  const StrengthBar({
    Key? key,
    required Animation<double> animation,
    required this.width,
    required this.thickness,
    required this.backgroundColor,
    required this.radius,
    required this.activeColor,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(width, thickness),
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
      },
    );
  }
}
