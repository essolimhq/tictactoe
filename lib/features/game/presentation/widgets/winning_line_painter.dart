import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int>? winningLine;
  final double progress;

  WinningLinePainter({
    required this.winningLine,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (winningLine == null || progress == 0) return;

    const spacing = 8.0;
    final cellSize = (size.width - spacing * 2) / 3;

    final start = _getCenter(winningLine![0], cellSize, spacing);
    final end = _getCenter(winningLine![2], cellSize, spacing);
    final current = Offset.lerp(start, end, progress)!;

    // Glow
    final glowPaint = Paint()
      ..color = const Color(0xFF00d4ff).withValues(alpha: 0.3)
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawLine(start, current, glowPaint);

    // Main line
    final paint = Paint()
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [Color(0xFF00d4ff), Colors.white, Color(0xFF00d4ff)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawLine(start, current, paint);
  }

  Offset _getCenter(int index, double cellSize, double spacing) {
    final row = index ~/ 3;
    final col = index % 3;
    final x = col * (cellSize + spacing) + cellSize / 2;
    final y = row * (cellSize + spacing) + cellSize / 2;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(WinningLinePainter old) =>
      old.winningLine != winningLine || old.progress != progress;
}
