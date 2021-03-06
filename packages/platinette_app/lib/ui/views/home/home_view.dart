import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/get_file_button/get_file_button.dart';
import 'package:platinette_app/ui/widgets/player_button/player_button.dart';
import 'package:platinette_app/ui/widgets/record_button/record_button.dart';
import 'package:platinette_app/ui/widgets/recordable_vinyl/recordable_vinyl.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Duration animationDuration = Duration(milliseconds: 600);
  Curve animationCurve = Curves.easeInCubic;

  // screen
  double width;
  double get halfWidth => width / 2;
  double height;
  double get halfHeight => height / 2;
  bool get isPortrait => width < height;

  // vinyl
  double vinylSize;
  double get halfVinyl => vinylSize / 2;
  double vinylStartMargin;
  double get vinylLeft => isPortrait ? halfWidth - halfVinyl : vinylStartMargin;
  double get vinylTop => isPortrait ? vinylStartMargin : halfHeight - halfVinyl;
  double get vinylEnd =>
      isPortrait ? vinylTop + vinylSize : vinylLeft + vinylSize;
  double get vinylCenterCircleEnd =>
      isPortrait ? vinylTop + vinylSize * 0.75 : vinylLeft + vinylSize * 0.75;
  double get vinylBottom => vinylTop + vinylSize;

  // vinyl shadow
  double vinylShadowSize;
  double get halfvinylShadow => vinylShadowSize / 2;
  double get vinylShadowLeft => isPortrait
      ? halfWidth - halfvinylShadow
      : vinylLeft + halfVinyl - halfvinylShadow;
  double get vinylShadowTop => isPortrait
      ? vinylTop + halfVinyl - halfvinylShadow
      : halfHeight - halfvinylShadow;

  // buttons
  double buttonSize;
  double get halfButton => buttonSize / 2;
  double buttonSpacing;
  double playerButtonScale;
  double buttonsEndMargin;
  double buttonsStart;
  double get playerButtonSize => buttonSize * playerButtonScale;
  double get buttonsBarSize =>
      2 * (buttonSpacing + buttonSize) + playerButtonSize;
  double get halfButtonBarSize => buttonsBarSize / 2;
  double get buttonsLeft =>
      isPortrait ? halfWidth - halfButtonBarSize : buttonsStart;
  double get buttonsTop =>
      isPortrait ? buttonsStart : halfHeight - halfButtonBarSize;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        computeSizes(model);
        return Container(
          color: model.mainColor ?? Colors.purple,
          child: Stack(
            alignment: isPortrait ? Alignment.topCenter : Alignment.centerLeft,
            children: [
              buildVinylShadow(),
              buildVinyl(),
              buildButtons(model),
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  void computeSizes(HomeViewModel model) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    double smallSize = isPortrait ? width : height;
    double bigSize = isPortrait ? height : width;

    double vinylScale = model.isPlaying ? 2 : 0.8;
    vinylSize = isPortrait ? vinylScale * width : vinylScale * height;
    vinylStartMargin = model.isPlaying ? -vinylSize * 0.25 : bigSize * 0.1;

    vinylShadowSize = vinylSize * 1.3;

    buttonSize = smallSize / 6;
    buttonSize = min(buttonSize, 65);
    buttonSpacing = buttonSize * 1;
    playerButtonScale = model.isPlaying ? 3 : 1;
    buttonsStart = model.isPlaying
        ? vinylCenterCircleEnd + bigSize * 0.05
        : vinylEnd + bigSize * 0.1;
    buttonsEndMargin = bigSize * 0.1;
  }

  Widget buildVinylShadow() => AnimatedPositioned(
        duration: animationDuration,
        curve: animationCurve,
        width: vinylShadowSize,
        height: vinylShadowSize,
        top: vinylShadowTop,
        left: vinylShadowLeft,
        child: FittedBox(
          child: Image.asset("assets/images/vinyl_shadow.png"),
        ),
      );

  Widget buildVinyl() => AnimatedPositioned(
        duration: animationDuration,
        curve: animationCurve,
        top: vinylTop,
        left: vinylLeft,
        width: vinylSize,
        height: vinylSize,
        child: RecordableVinyl(),
      );

  Widget buildButtons(HomeViewModel model) {
    var children = List<Widget>();
    children.add(loadButton(color: Colors.green, size: buttonSize));
    children.add(buttonSpacer());
    children.add(AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      width: playerButtonSize,
      height: playerButtonSize,
      child: PlayerButton(
        animationDuration: animationDuration * 1,
      ),
    ));
    children.add(buttonSpacer());
    children.add(startRecordButton(color: Colors.blue, size: buttonSize));
    return AnimatedPositioned(
      duration: animationDuration,
      curve: animationCurve,
      top: buttonsTop,
      left: buttonsLeft,
      child: isPortrait
          ? Row(
              children: children,
            )
          : Column(
              children: children,
            ),
    );
  }

  Widget buttonSpacer() => isPortrait
      ? SizedBox(width: buttonSpacing)
      : SizedBox(height: buttonSpacing);

  Widget loadButton({Color color, void Function() onClick, double size}) =>
      SizedBox(
        width: size,
        height: size,
        child: GetFileButton(
          animationDuration: animationDuration,
          animationCurve: animationCurve,
        ),
      );

  Widget startRecordButton(
          {Color color, void Function() onClick, double size}) =>
      SizedBox(
        width: size,
        height: size,
        child: RecordButton(
          animationDuration: animationDuration,
          animationCurve: animationCurve,
        ),
      );
}
