import 'package:flutter/material.dart';

/// Rotate its [child] of [angle] radians
class Rotation extends StatelessWidget {
  final Widget child;
  final double angle;

  const Rotation({Key key, this.child, this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(angle != null);
    return Transform.rotate(angle: angle, child: child);
  }
}
