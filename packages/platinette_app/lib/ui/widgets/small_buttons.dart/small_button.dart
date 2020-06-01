import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/deserve_package/circular_gauge.dart/circular_gauge.dart';

class SmallButton extends StatefulWidget {
  final Duration animationDuration;
  final void Function() onClick;
  final Widget child;
  final bool active;

  const SmallButton({
    Key key,
    @required this.animationDuration,
    @required this.onClick,
    this.child,
    @required this.active,
  }) : super(key: key);
  @override
  _SmallButtonState createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> fillOverCircleAnimation;
  Animation<double> fillCircleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    fillOverCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.4, 1.0, curve: Curves.easeInOut)));
    fillCircleAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.4, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SmallButton oldWidget) {
    if (oldWidget.active != widget.active) {
      controller.animateTo(
        widget.active ? 1.0 : 0.0,
        duration: animateToDuration(oldWidget.active),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  Duration animateToDuration(bool oldActive) => oldActive
      ? widget.animationDuration * (controller.value)
      : widget.animationDuration * (1 - controller.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        alignment: Alignment.center,
        children: [
          buildCircle(),
          buildOverCircle(),
        ],
      ),
    );
  }

  Widget buildOverCircle() => CircularGauge(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        fillValue: fillOverCircleAnimation.value,
        strokeWidth: 1,
      );

  Widget buildCircle() => CircularGauge(
        backgroundColor: Colors.transparent,
        color: Colors.black,
        fillValue: fillOverCircleAnimation.value,
        strokeWidth: 1,
      );
}
