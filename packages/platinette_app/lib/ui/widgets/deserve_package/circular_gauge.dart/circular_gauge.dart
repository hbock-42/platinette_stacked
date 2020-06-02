import 'package:flutter/material.dart';

import 'circular_gauge_painter.dart';

class CircularGauge extends StatelessWidget {
  final double strokeWidth;
  final Color backgroundColor;
  final Color color;
  final Widget child;
  final double fillValue;
  final bool clockWise;
  final double startAngle;

  /// [strokeWidth] width of the stroke
  ///
  /// [backgroundColor] color of the always full stroke
  ///
  /// [color] color of the filling stroke
  ///
  /// [fillValue] must be between 0 and 1 included
  ///
  /// [startAngle] in radian, 0 is the most right point, it turns
  /// counter clockwise, so pi / 2 is most top point
  ///
  /// [clockWise] should the circle fill clockwise or not
  ///
  /// [child] widget to place under the gauge. You must wrap
  /// it with a padding of size [strokeWidth] if you want to
  /// avoid the gauge to overlap on it
  const CircularGauge({
    Key key,
    @required this.strokeWidth,
    @required this.color,
    @required this.fillValue,
    this.backgroundColor,
    this.child,
    this.clockWise = false,
    this.startAngle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Center(child: this.child),
      painter: backgroundColor != null
          ? CircularGaugePainter(
              strokeWidth: this.strokeWidth,
              color: this.backgroundColor,
              clockWise: clockWise,
              startAngleInRad: startAngle,
            )
          : null,
      foregroundPainter: CircularGaugePainter(
        strokeWidth: this.strokeWidth,
        isForeground: true,
        color: this.color,
        fillValue: this.fillValue.clamp(0, 1),
        clockWise: clockWise,
        startAngleInRad: startAngle,
      ),
    );
  }
}
