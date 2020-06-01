import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/player_button/player_button.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Duration animationDuration = Duration(milliseconds: 300);
  Curve animationCurve = Curves.easeIn;

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
          color: Colors.purple,
          child: Stack(
            alignment: isPortrait ? Alignment.topCenter : Alignment.centerLeft,
            children: [
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

    buttonSize = smallSize / 6;
    buttonSize = min(buttonSize, 75);
    buttonSpacing = buttonSize * 0.6;
    playerButtonScale = model.isPlaying ? 2.5 : 1;
    buttonsStart = model.isPlaying
        ? vinylCenterCircleEnd + bigSize * 0.05
        : vinylEnd + bigSize * 0.1;
    buttonsEndMargin = bigSize * 0.1;
  }

  Widget buildVinyl() => AnimatedPositioned(
        duration: animationDuration,
        curve: animationCurve,
        top: vinylTop,
        left: vinylLeft,
        width: vinylSize,
        height: vinylSize,
        child: Image.asset(
          "assets/images/vinyl.png",
          width: vinylSize,
          height: vinylSize,
          fit: BoxFit.fill,
        ),
      );

  Widget buildButtons(HomeViewModel model) {
    var children = List<Widget>();
    children.add(fakeButton(color: Colors.green, size: buttonSize));
    children.add(buttonSpacer());
    children.add(AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      width: playerButtonSize,
      height: playerButtonSize,
      child: PlayerButton(
        animationDuration: animationDuration * 2,
      ),
    ));
    children.add(buttonSpacer());
    children.add(fakeButton(color: Colors.blue, size: buttonSize));
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

  Widget fakeButton({Color color, void Function() onClick, double size}) =>
      Listener(
        onPointerUp: (_) => onClick.call(),
        child: AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            color: color,
          ),
        ),
      );
}
