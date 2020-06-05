import 'package:flutter/material.dart';

class WidgetRecorder extends StatefulWidget {
  final Widget child;
  final AnimationController childAnimationControler;
  final int fps;

  const WidgetRecorder({
    Key key,
    this.child,
    this.childAnimationControler,
    this.fps,
  }) : super(key: key);
  @override
  _WidgetRecorderState createState() => _WidgetRecorderState();
}

class _WidgetRecorderState extends State<WidgetRecorder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
