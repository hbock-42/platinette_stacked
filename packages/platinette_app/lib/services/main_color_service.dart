import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:main_color/main_color.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class MainColorService with ReactiveServiceMixin {
  RxValue<Color> _mainColor = RxValue(initial: Colors.white);

  Color get mainColor => _mainColor.value;

  MainColorService() {
    listenToReactiveValues([_mainColor]);
  }

  void setMainColorFromImageData(Uint8List imageData) {
    if (imageData != null) {
      _mainColor.value = MainColor.fromImageBytes(imageData,
          staturationCoef: 0.3, valueCoef: 1.4);
    }
  }
}
