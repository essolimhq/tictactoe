import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/presentation/widgets/winning_line_painter.dart';

class AnimatedWinningLine extends StatefulWidget {
  final Widget child;
  final List<int>? winningLine;

  const AnimatedWinningLine({
    super.key,
    required this.child,
    required this.winningLine,
  });

  @override
  State<AnimatedWinningLine> createState() => _AnimatedWinningLineState();
}

class _AnimatedWinningLineState extends State<AnimatedWinningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(AnimatedWinningLine oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.winningLine != null && oldWidget.winningLine == null) {
      _controller.forward(from: 0);
    }

    if (widget.winningLine == null && oldWidget.winningLine != null) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: WinningLinePainter(
            winningLine: widget.winningLine,
            progress: _controller.value,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
