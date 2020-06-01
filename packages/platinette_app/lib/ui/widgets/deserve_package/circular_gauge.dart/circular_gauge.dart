import 'package:flutter/material.dart';

import 'circular_gauge_painter.dart';

class CircularGauge extends StatelessWidget {
  final double strokeWidth;
  final Color backgroundColor;
  final Color color;
  final Widget child;
  final double fillValue;
  final bool clockWise;

  /// [strokeWidth] width of the stroke <br />
  /// [backgroundColor] color of the always full stroke <br />
  /// [color] color of the filling stroke <br />
  /// [fillValue] must be between 0 and 1 included <br />
  const CircularGauge({
    Key key,
    @required this.strokeWidth,
    @required this.backgroundColor,
    @required this.color,
    @required this.fillValue,
    this.child,
    this.clockWise = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Center(child: this.child),
      painter: CircularGaugePainter(
        strokeWidth: this.strokeWidth,
        color: this.backgroundColor,
        clockWise: clockWise,
      ),
      foregroundPainter: CircularGaugePainter(
        strokeWidth: this.strokeWidth,
        isForeground: true,
        color: this.color,
        fillValue: this.fillValue.clamp(0, 1),
        clockWise: clockWise,
      ),
    );
  }
}
