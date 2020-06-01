import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/circular_gauge.dart/circular_gauge.dart';
import 'package:platinette_app/ui/widgets/deserve_package/animated_rotation.dart';
import 'package:platinette_app/ui/widgets/deserve_package/curves/elastic_out_flatten_curve.dart';
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
  static const double littleStrokeWidth = 1;
  static const double sizeRatioMiddleCircle = 0.556;
  static const double sizeRatioInnerCircle = 0.282;

  TextStyle _textStyle = TextStyle(
    color: Color(0xFFF4F8F8),
    fontSize: 1,
    decoration: TextDecoration.none,
  );
  double _textMargin;
  double _fontSize;

  bool oldIsPlaying;
  AnimationController controller;
  Animation<Color> colorAnimation;
  Animation<double> fillInnerCircleAnimation;
  Animation<double> fillMiddleCircleAnimation;
  Animation<double> textOpacityAnimation;
  Animation<double> dotScaleAnimation;
  Animation<double> dotOpacityAnimation;
  Duration get animateToDuration => oldIsPlaying
      ? widget.animationDuration * (controller.value)
      : widget.animationDuration * (1 - controller.value);
  int positionId;
  double middleCircleDiameter;
  double innerCircleDiameter;
  double dotDiameter;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    colorAnimation = ColorTween(begin: Colors.black, end: Colors.white).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.easeOutCirc),
            reverseCurve: Curves.easeOut));
    fillMiddleCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.8, curve: Curves.easeInOut)));
    fillInnerCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.6, curve: Curves.easeInOut)));
    textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
    dotScaleAnimation = Tween<double>(begin: 0.3, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 0.8, curve: Curves.easeInOut)));
    dotOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 1.0, curve: Curves.easeInOut)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          ViewModelBuilder<PlayerButtonViewModel>.reactive(
        builder: (context, model, child) {
          setIsPlaying(model);
          computeSizes(constraints, model);
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  buildOuterCircle(model: model),
                  buildMiddleCircle(model: model, constraints: constraints),
                  buildInnerCircle(constraints: constraints, model: model),
                  ...buildTexts(model: model, constraints: constraints),
                  buildDot(),
                ],
              );
            },
          );
        },
        viewModelBuilder: () => PlayerButtonViewModel(),
      ),
    );
  }

  void setIsPlaying(PlayerButtonViewModel model) {
    if (oldIsPlaying == null) {
      oldIsPlaying = model.isPlaying;
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

  void computeSizes(BoxConstraints constraints, PlayerButtonViewModel model) {
    _fontSize = 0.141 * constraints.maxWidth;
    _textStyle = _textStyle.copyWith(fontSize: _fontSize);
    _textMargin = 0.068 * constraints.maxWidth;
    innerCircleDiameter = sizeRatioInnerCircle * constraints.maxWidth;
    middleCircleDiameter = sizeRatioMiddleCircle * constraints.maxWidth;
    dotDiameter = (middleCircleDiameter - innerCircleDiameter) / 2 - 3;
    mapRpmToPositions(model.rpm);
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
            // color: model.isPlaying ? Colors.white : Colors.black,
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
            width: middleCircleDiameter,
            height: middleCircleDiameter,
            child: CircularTimer(
              backgroundColor: Colors.transparent,
              // color: colorAnimation.value,
              color: Colors.white,
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
          width: innerCircleDiameter,
          height: innerCircleDiameter,
          child: CircularTimer(
            backgroundColor: Colors.transparent,
            // color: colorAnimation.value,
            color: Colors.white,
            fillValue: fillInnerCircleAnimation.value,
            strokeWidth: 2,
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

  Widget buildDot() {
    return Opacity(
      opacity: dotOpacityAnimation.value,
      child: AnimatedRotation(
        curve: ElasticOutFlattenCurve(),
        duration: Duration(milliseconds: 1900),
        angle: pi * 2 * positionId / 3 + pi,
        child: Transform.translate(
          offset: Offset(0, (middleCircleDiameter - dotDiameter) / 2 - 2),
          child: Transform.scale(
            scale: dotScaleAnimation.value,
            child: SizedBox(
              width: dotDiameter,
              height: dotDiameter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(dotDiameter),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTexts({
    @required PlayerButtonViewModel model,
    @required BoxConstraints constraints,
  }) {
    var texts = List<Widget>();
    texts.add(buildText("33", 0, () => model.select33Rpm(), constraints));
    texts.add(buildText("45", 1, () => model.select45Rpm(), constraints));
    texts.add(buildText("78", 2, () => model.select78Rpm(), constraints));
    return texts;
  }

  Widget buildText(
    String text,
    int i,
    void Function() onPointerUp,
    BoxConstraints constraints,
  ) {
    return Transform.rotate(
      angle: getRotationNumbers(i),
      child: Transform.translate(
        offset: getTranslation(
            i,
            (constraints.maxWidth / 2) -
                (_textStyle.fontSize / 2) -
                _textMargin +
                3),
        child: Opacity(
          opacity: textOpacityAnimation.value,
          child: Listener(
            onPointerUp: (_) => onPointerUp(),
            child: Text(text, style: _textStyle),
          ),
        ),
      ),
    );
  }

  double getRotationNumbers(int positionId) =>
      positionId == 0 ? 0 : pi * 2 * positionId / 3 + pi;

  Offset getTranslation(int positionId, double distance) {
    double sign = positionId == 0 ? -1 : 1;
    return Offset(0, sign * distance);
  }

  void mapRpmToPositions(int rpm) {
    if (rpm == 33) {
      positionId = 0;
    } else if (rpm == 45) {
      positionId = 1;
    } else if (rpm == 78) {
      positionId = 2;
    }
  }
}
