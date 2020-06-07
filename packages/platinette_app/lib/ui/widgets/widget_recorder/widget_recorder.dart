import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class WidgetRecorder extends StatefulWidget {
  final Widget child;
  final WidgetRecorderController controller;
  WidgetRecorder({
    Key key,
    this.child,
    @required this.controller,
  }) : super(key: key);
  @override
  _WidgetRecorderState createState() => _WidgetRecorderState();
}

class _WidgetRecorderState extends State<WidgetRecorder> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.controller._containerKey,
      child: widget.child,
    );
  }
}

class WidgetRecorderController {
  GlobalKey _containerKey;
  RecorderInfo _recorderInfo;
  List<img.Image> _frameImages;
  final AnimationController childAnimationControler;
  final Fps fps;

  int get _recordedFrameCount => _frameImages == null ? 0 : _frameImages.length;

  WidgetRecorderController({
    @required this.childAnimationControler,
    this.fps = Fps.Fps25,
  }) : assert(childAnimationControler != null) {
    _containerKey = GlobalKey();
    _recorderInfo = RecorderInfo(
      Fps.Fps50,
      childAnimationControler.duration.inMilliseconds,
    );
  }

  Future<img.Animation> captureAnimation({
    double pixelRatio: 1,
  }) async {
    _frameImages = List<img.Image>();
    bool readyForNextFrame = true;
    while (_recordedFrameCount < _recorderInfo.totalFrameNeeded) {
      if (readyForNextFrame) {
        readyForNextFrame = false;
        childAnimationControler.value =
            _recordedFrameCount / _recorderInfo.totalFrameNeeded;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          ui.Image image = await _captureAsUiImage(pixelRatio: pixelRatio);
          _addUiImageToAnimation(image);
          readyForNextFrame = true;
        });
      }
    }
    return _createAnimation();
  }

  Future _addUiImageToAnimation(ui.Image image) async {
    var frameDuration = Duration(
      milliseconds: _recorderInfo.frameDurationsInMs[_recordedFrameCount],
    );
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    List<int> pngBytes = byteData.buffer.asUint8List();
    img.Image decodedImage = img.decodeImage(pngBytes)
      ..duration = frameDuration.inMilliseconds;
    decodedImage.blendMethod = img.BlendMode.source;
    _frameImages.add(decodedImage);
  }

  img.Animation _createAnimation() {
    var animation = img.Animation();
    _frameImages.forEach((frame) => animation.addFrame(frame));
    return animation;
  }

  Future<ui.Image> _captureAsUiImage(
      {double pixelRatio: 1,
      Duration delay: const Duration(milliseconds: 20)}) {
    //Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return new Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary =
            this._containerKey.currentContext.findRenderObject();
        return await boundary.toImage(pixelRatio: pixelRatio);
      } catch (Exception) {
        throw (Exception);
      }
    });
  }
}

class Fps {
  final int _value;

  const Fps._(this._value);
  int toInt() {
    return _value;
  }

  static const Fps Fps5 = Fps._(5);
  static const Fps Fps10 = Fps._(10);
  static const Fps Fps20 = Fps._(20);
  static const Fps Fps25 = Fps._(25);
  static const Fps Fps50 = Fps._(50);
}

class RecorderInfo {
  final Fps fps;
  int totalFrameNeeded;
  List<int> frameDurationsInMs;

  RecorderInfo(this.fps, int durationInMs) {
    double dottedFrameCount =
        (fps.toInt() * durationInMs).roundToDouble() / 1000;
    int frameDurationInMs = (1000 / fps.toInt()).round();
    if (dottedFrameCount.round().roundToDouble() == dottedFrameCount) {
      totalFrameNeeded = dottedFrameCount.round();
      frameDurationsInMs =
          List<int>.filled(totalFrameNeeded, frameDurationInMs);
    } else {
      totalFrameNeeded = dottedFrameCount.floor() + 1;
      frameDurationsInMs =
          List<int>.filled(totalFrameNeeded, frameDurationInMs);
      frameDurationsInMs.last =
          durationInMs - (dottedFrameCount.floor() * frameDurationInMs);
    }
  }
}
