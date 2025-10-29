import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.primaryColor = const Color(0xFFDC0000),
    this.secondaryColor = const Color(0xFFA00000),
  });

  @override
  State<AnimatedBackground> createState() => _FloatingShapesBackgroundState();
}

class _FloatingShapesBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<FloatingShape> _shapes;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeShapes();
  }

  void _initializeShapes() {
    _shapes = [];
    _controllers = [];

    for (int i = 0; i < 10; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: 20 + i * 5),
        vsync: this,
      )..repeat();

      _controllers.add(controller);

      _shapes.add(
        FloatingShape(
          controller: controller,
          size: 100.0 + i * 30,
          initialX: math.Random().nextDouble(),
          initialY: math.Random().nextDouble(),
          color: i.isEven ? widget.primaryColor : widget.secondaryColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4A90E2), // Soft blue
                Color(0xFF7B68EE), // Medium slate blue
              ],
            ),
          ),
        ),
        ..._shapes.map(
          (shape) => AnimatedBuilder(
            animation: shape.controller,
            builder: (context, child) {
              final progress = shape.controller.value;
              final x = math.sin(progress * 2 * math.pi) * 0.2 + shape.initialX;
              final y = math.cos(progress * 2 * math.pi) * 0.2 + shape.initialY;

              return Positioned(
                left: x * MediaQuery.of(context).size.width - shape.size / 2,
                top: y * MediaQuery.of(context).size.height - shape.size / 2,
                child: Container(
                  width: shape.size,
                  height: shape.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        shape.color.withValues(alpha: 0.3),
                        shape.color.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class FloatingShape {
  final AnimationController controller;
  final double size;
  final double initialX;
  final double initialY;
  final Color color;

  FloatingShape({
    required this.controller,
    required this.size,
    required this.initialX,
    required this.initialY,
    required this.color,
  });
}
