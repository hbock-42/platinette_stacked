import 'dart:math';

import 'package:flutter/material.dart';

class CircularGaugePainter extends CustomPainter {
  final Color color;
  final bool isForeground;
  final double tempStrokeWidth;
  final double tempFillValue;
  final bool clockWise;
  final double realStartAngleInRad;

  const CircularGaugePainter({
    @required this.color,
    @required double strokeWidth,
    @required this.clockWise,
    double startAngleInRad,
    this.isForeground = false,
    double fillValue,
  })  : tempStrokeWidth = strokeWidth,
        tempFillValue = fillValue,
        realStartAngleInRad = startAngleInRad ?? 0;

  @override
  void paint(Canvas canvas, Size size) {
    double fillValue = this.tempFillValue;
    if (fillValue == null) {
      fillValue = 1;
    }
    double strokeWidth = this.tempStrokeWidth;
    Paint paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.stroke
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
      -realStartAngleInRad,
      clockWise ? pi * 2 * fillValue : -2 * pi * fillValue,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularGaugePainter oldDelegate) {
    return oldDelegate.tempFillValue != this.tempFillValue;
  }
}
