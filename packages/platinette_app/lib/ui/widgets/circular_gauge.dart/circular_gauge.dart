import 'package:flutter/material.dart';

import 'circular_gauge_painter.dart';

class CircularTimer extends StatelessWidget {
  final double strokeWidth;
  final Color backgroundColor;
  final Color color;
  final Widget child;
  final double fillValue;

  /// [strokeWidth] width of the stroke <br />
  /// [backgroundColor] color of the always full stroke <br />
  /// [color] color of the filling stroke <br />
  /// [fillValue] must be between 0 and 1 included <br />
  const CircularTimer({
    Key key,
    @required this.strokeWidth,
    @required this.backgroundColor,
    @required this.color,
    @required this.fillValue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Center(child: this.child),
      painter: CircularGaugePainter(
          strokeWidth: this.strokeWidth, color: this.backgroundColor),
      foregroundPainter: CircularGaugePainter(
          strokeWidth: this.strokeWidth,
          isForeground: true,
          color: this.color,
          fillValue: this.fillValue.clamp(0, 1)),
    );
  }
}
