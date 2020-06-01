import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'rotation.dart';

class AnimatedRotation extends StatefulWidget {
  final Duration duration;
  final double angle;
  final Widget child;
  final Curve curve;
  final bool useQuickestPath;

  const AnimatedRotation({
    Key key,
    @required this.duration,
    @required this.angle,
    this.child,
    this.curve,
    this.useQuickestPath = true,
  }) : super(key: key);

  @override
  _AnimatedTranslationState createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState extends State<AnimatedRotation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _angleAnimation;
  Curve _curve;

  @override
  void initState() {
    assert(widget.duration != null);
    assert(widget.angle != null);

    if (widget.curve == null) {
      _curve = Curves.linear;
    } else {
      _curve = widget.curve;
    }

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _angleAnimation =
        Tween(begin: widget.angle, end: widget.angle).animate(_controller);
    super.initState();
  }

  double _getAngle(bool useQuickestPath, double angle) =>
      useQuickestPath ? angle % (2 * math.pi) : angle;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedRotation oldWidget) {
    if (oldWidget.angle != widget.angle ||
        oldWidget.useQuickestPath != widget.useQuickestPath) {
      double angleBegin = _getAngle(widget.useQuickestPath, oldWidget.angle);
      double angleEnd = _getAngle(widget.useQuickestPath, widget.angle);
      if ((angleBegin - angleEnd).abs() > math.pi) {
        if (angleBegin > angleEnd) {
          angleBegin -= 2 * math.pi;
        } else {
          angleEnd -= 2 * math.pi;
        }
      }

      _angleAnimation = Tween(begin: angleBegin, end: angleEnd)
          .animate(CurvedAnimation(parent: _controller, curve: _curve));
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Rotation(
          angle: _angleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
