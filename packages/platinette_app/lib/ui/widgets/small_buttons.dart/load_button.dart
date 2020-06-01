import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/deserve_package/circular_gauge.dart/circular_gauge.dart';
import 'package:stacked/stacked.dart';

import 'load_button_viewmodel.dart';

class LoadButton extends StatefulWidget {
  final Duration animationDuration;
  final Widget child;

  const LoadButton({
    Key key,
    @required this.animationDuration,
    this.child,
  }) : super(key: key);
  @override
  _LoadButtonState createState() => _LoadButtonState();
}

class _LoadButtonState extends State<LoadButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> fillOverCircleAnimation;
  Animation<double> fillCircleAnimation;
  bool oldIsPlaying;
  Duration get animateToDuration => oldIsPlaying
      ? widget.animationDuration * (controller.value)
      : widget.animationDuration * (1 - controller.value);

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
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadButtonViewModel>.reactive(
      builder: (context, model, child) {
        setIsPlaying(model);
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
      },
      viewModelBuilder: () => LoadButtonViewModel(),
    );
  }

  void setIsPlaying(LoadButtonViewModel model) {
    if (oldIsPlaying == null) {
      oldIsPlaying = model.isPlaying;
      if (model.isPlaying) {
        controller.value = 1;
      }
    } else if (oldIsPlaying != model.isPlaying) {
      controller.animateTo(
        model.isPlaying ? 1.0 : 0.0,
        duration: animateToDuration,
      );
      oldIsPlaying = model.isPlaying;
    }
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
        fillValue: fillCircleAnimation.value,
        strokeWidth: 1,
        clockWise: true,
      );
}
