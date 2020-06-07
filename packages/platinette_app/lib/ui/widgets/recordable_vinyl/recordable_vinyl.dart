import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/recordable_vinyl/recordable_vinyl_viewmodel.dart';
import 'package:platinette_app/ui/widgets/vinyl/vinyl.dart';
import 'package:platinette_app/ui/widgets/widget_recorder/widget_recorder.dart';
import 'package:stacked/stacked.dart';

class RecordableVinyl extends StatefulWidget {
  @override
  _RecordableVinylState createState() => _RecordableVinylState();
}

class _RecordableVinylState extends State<RecordableVinyl>
    with SingleTickerProviderStateMixin {
  bool recording = false;
  bool isPlaying;
  int rpm;
  AnimationController animationController;
  WidgetRecorderController widgetRecorderController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecordableVinylViewModel>.reactive(
      builder: (context, model, child) {
        listenValueChange(model);
        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => WidgetRecorder(
            controller: widgetRecorderController,
            child: Vinyl(rotation: animationController.value * pi * 2),
          ),
        );
      },
      viewModelBuilder: () => RecordableVinylViewModel(),
    );
  }

  void listenValueChange(RecordableVinylViewModel model) {
    if (rpm == null || rpm != model.rpm) {
      rpm = model.rpm;
      animationController.duration = animationDurationFromRpm(rpm);
      if (isPlaying) {
        animationController.repeat();
      }
    }

    if (isPlaying == null || isPlaying != model.isPlaying) {
      isPlaying = model.isPlaying;
      if (isPlaying) {
        animationController.repeat();
      } else {
        animationController.stop();
      }
    }

    if (recording == null || recording != model.isRecording) {
      recording = model.isRecording;
      widgetRecorderController = WidgetRecorderController(
        childAnimationControler: animationController,
        fps: Fps.Fps10,
      );
      widgetRecorderController.addListener(notifyNewFrameReady);
      widgetRecorderController.captureAnimation(pixelRatio: 0.5);
      // widgetRecorderController.removeListener(notifyNewFrameReady);
    }
  }

  void notifyNewFrameReady() {
    print("in callb");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widgetRecorderController.newFrameReady());
  }

  Duration animationDurationFromRpm(int rpm) {
    return Duration(milliseconds: (60 / rpm * 1000).round());
  }
}
