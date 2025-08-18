import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Axis direction;
  final double dashLength;
  final double dashThickness;
  final double spacing;
  final Color color;
  final int? lineLength; // Optional: Specify length in pixels.

  const DashedLine({
    super.key,
    this.direction = Axis.horizontal,
    this.dashLength = 10.0,
    this.dashThickness = 2.0,
    this.spacing = 4.0,
    this.color = Colors.black,
    this.lineLength,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: direction == Axis.horizontal
          ? Size(lineLength?.toDouble() ?? double.infinity, dashThickness)
          : Size(dashThickness, lineLength?.toDouble() ?? double.infinity),
      painter: _DashedLinePainter(
        direction: direction,
        dashLength: dashLength,
        dashThickness: dashThickness,
        spacing: spacing,
        color: color,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Axis direction;
  final double dashLength;
  final double dashThickness;
  final double spacing;
  final Color color;

  _DashedLinePainter({
    required this.direction,
    required this.dashLength,
    required this.dashThickness,
    required this.spacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double start = 0.0;
    final maxLength =
        direction == Axis.horizontal ? size.width : size.height;

    while (start < maxLength) {
      final dashRect = direction == Axis.horizontal
          ? Rect.fromLTWH(start, 0, dashLength, dashThickness)
          : Rect.fromLTWH(0, start, dashThickness, dashLength);

      canvas.drawRect(dashRect, paint);
      start += dashLength + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
