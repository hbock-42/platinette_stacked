import 'dart:math';

import 'package:flutter/material.dart';

class CircularGaugePainter extends CustomPainter {
  final Color color;
  final bool isForeground;
  final double tempStrokeWidth;
  final double tempFillValue;

  const CircularGaugePainter({
    @required this.color,
    @required double strokeWidth,
    this.isForeground = false,
    double fillValue,
  })  : tempStrokeWidth = strokeWidth,
        tempFillValue = fillValue;

  @override
  void paint(Canvas canvas, Size size) {
    double fillValue = this.tempFillValue;
    if (fillValue == null) {
      fillValue = 1;
    }
    double strokeWidth = this.tempStrokeWidth;
    if (!isForeground && fillValue == 1) {
      strokeWidth = 0;
    }
    Paint paint = Paint()
      ..color = this.color
      ..style = !isForeground && fillValue == 1
          ? PaintingStyle.fill
          : PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;
    var diameterWithStroke =
        (size.height < size.width ? size.height : size.width);
    var diameter = diameterWithStroke - strokeWidth;
    var halfStrokeWidth = strokeWidth / 2;
    Rect rect = Offset(halfStrokeWidth + (size.width - diameterWithStroke) / 2,
            halfStrokeWidth + (size.height - diameterWithStroke) / 2) &
        Size.square(diameter);
    canvas.drawArc(
      rect,
      2 * pi - (2 * pi * fillValue) - pi * 0.5,
      pi * 2 * fillValue,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularGaugePainter oldDelegate) {
    return oldDelegate.tempFillValue != this.tempFillValue;
  }
}
