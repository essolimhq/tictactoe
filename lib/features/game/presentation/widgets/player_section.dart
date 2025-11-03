import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlayerSection extends StatelessWidget {
  final String symbol;
  final String label;
  final bool isActive;

  const PlayerSection({
    super.key,
    required this.symbol,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Opacity(
      opacity: isActive ? 1.0 : 0.5,
      child: Column(
        children: [
          Text(symbol, style: const TextStyle(fontSize: 32)),
          Text(label, style: const TextStyle(fontSize: 32)),
        ],
      ),
    );

    if (!isActive) return widget;

    return widget
        .animate(
          key: ValueKey('$symbol-pulse'),
          onPlay: (controller) => controller.repeat(),
        )
        .scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.05, 1.05),
          duration: 600.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .scale(
          begin: const Offset(1.05, 1.05),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.easeInOut,
        );
  }
}
