import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int>? winningLine;
  final Animation<double> progress;

  WinningLinePainter({
    required this.winningLine,
    required this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (winningLine == null) return;

    final cellSize = size.width / 3;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: [Color(0xFF00d4ff), Colors.white, Color(0xFF00d4ff)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Calculate start and end points
    Offset start = _getCellCenter(winningLine![0], cellSize);
    Offset end = _getCellCenter(winningLine![2], cellSize);

    // Animate the line
    Offset currentEnd = Offset.lerp(start, end, progress.value)!;

    canvas.drawLine(start, currentEnd, paint);
  }

  Offset _getCellCenter(int index, double cellSize) {
    int row = index ~/ 3;
    int col = index % 3;
    return Offset(
      col * cellSize + cellSize / 2,
      row * cellSize + cellSize / 2,
    );
  }

  @override
  bool shouldRepaint(WinningLinePainter oldDelegate) {
    return oldDelegate.winningLine != winningLine || oldDelegate.progress != progress;
  }
}
