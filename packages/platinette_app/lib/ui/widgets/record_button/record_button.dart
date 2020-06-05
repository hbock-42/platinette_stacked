import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/on_tap_listener/on_tap_listener.dart';
import 'package:platinette_app/ui/widgets/record_button/record_button_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RecordButton extends StatelessWidget {
  final Duration animationDuration;
  final Curve animationCurve;

  const RecordButton({
    Key key,
    @required this.animationDuration,
    this.animationCurve,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<RecordButtonViewModel>.reactive(
        builder: (context, model, child) => LayoutBuilder(
          builder: (context, constraints) => OnTapListener(
            onTap: () => model.startRecording(),
            child: AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    max(constraints.maxHeight, constraints.maxWidth)),
                border: Border.all(
                  color: model.isPlaying ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
        viewModelBuilder: () => RecordButtonViewModel(),
      );
}
