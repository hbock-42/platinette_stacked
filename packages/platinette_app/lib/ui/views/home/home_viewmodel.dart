import 'package:flutter/material.dart';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/main_color_service.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final _playerService = locator<PlayerService>();
  bool get isPlaying => _playerService.state == PlayerState.playing;
  final _mainColorService = locator<MainColorService>();
  Color get mainColor => _mainColorService.mainColor;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_playerService, _mainColorService];
}
