import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/circular_gauge.dart/circular_gauge.dart';
import 'package:platinette_app/ui/widgets/player_button/player_button_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PlayerButton extends StatefulWidget {
  final Duration animationDuration;
  const PlayerButton({Key key, @required this.animationDuration})
      : super(key: key);

  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton>
    with SingleTickerProviderStateMixin {
  bool oldIsPlaying;
  AnimationController controller;
  Animation<Color> colorAnimation;
  Animation<double> fillInnerCircleAnimation;
  Animation<double> fillMiddleCircleAnimation;
  Duration get animateToDuration => oldIsPlaying
      ? widget.animationDuration * (controller.value)
      : widget.animationDuration * (1 - controller.value);
  static const double littleStrokeWidth = 1;
  static const double sizeRatioMiddleCircle = 0.556;
  static const double sizeRatioInnerCircle = 0.282;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    colorAnimation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);
    fillMiddleCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.4, 1, curve: Curves.easeInOut)));
    fillInnerCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.8, curve: Curves.easeInOut)));
    // colorAnimation = Tween(begin: Colors.black, end: Colors.white).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          ViewModelBuilder<PlayerButtonViewModel>.reactive(
        builder: (context, model, child) {
          setIsPlyaing(model);
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  buildOuterCircle(model: model),
                  buildMiddleCircle(model: model, constraints: constraints),
                  buildInnerCircle(constraints: constraints, model: model)
                ],
              );
            },
          );
        },
        viewModelBuilder: () => PlayerButtonViewModel(),
      ),
    );
  }

  void setIsPlyaing(PlayerButtonViewModel model) {
    if (oldIsPlaying == null) {
      oldIsPlaying = model.isPlaying;
      // setState ?
      if (model.isPlaying) {
        controller.value = 1;
      }
    } else if (oldIsPlaying != model.isPlaying) {
      controller.animateTo(
        model.isPlaying ? 1.0 : 0.0,
        duration: animateToDuration,
        // duration: widget.animationDuration,
      );
      oldIsPlaying = model.isPlaying;
    }
  }

  Widget buildOuterCircle({
    Widget child,
    @required PlayerButtonViewModel model,
  }) =>
      IgnorePointer(
        ignoring: model.isPlaying,
        child: Listener(
          onPointerUp: (_) => model.switchPlayerState(),
          child: CircularTimer(
            backgroundColor: Colors.transparent,
            color: colorAnimation.value,
            fillValue: 1,
            strokeWidth: littleStrokeWidth,
            child: child,
          ),
        ),
      );

  Widget buildMiddleCircle({
    Widget child,
    @required BoxConstraints constraints,
    @required PlayerButtonViewModel model,
  }) =>
      IgnorePointer(
        ignoring: model.isPlaying,
        child: Listener(
          onPointerUp: (_) => model.switchPlayerState(),
          child: Container(
            width: sizeRatioMiddleCircle * constraints.maxWidth,
            height: sizeRatioMiddleCircle * constraints.maxHeight,
            child: CircularTimer(
              backgroundColor: Colors.transparent,
              color: colorAnimation.value,
              fillValue: fillMiddleCircleAnimation.value,
              strokeWidth: littleStrokeWidth,
              child: child,
            ),
          ),
        ),
      );

  Widget buildInnerCircle({
    @required BoxConstraints constraints,
    @required PlayerButtonViewModel model,
  }) =>
      Listener(
        onPointerUp: (_) => model.switchPlayerState(),
        child: Container(
          width: sizeRatioInnerCircle * constraints.maxWidth,
          height: sizeRatioInnerCircle * constraints.maxHeight,
          child: CircularTimer(
            backgroundColor: Colors.transparent,
            color: colorAnimation.value,
            fillValue: fillInnerCircleAnimation.value,
            strokeWidth: littleStrokeWidth,
            child: Text(
              model.isPlaying ? "pl" : "pa",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
}
