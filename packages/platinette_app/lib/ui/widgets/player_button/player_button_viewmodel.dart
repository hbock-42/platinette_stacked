import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class PlayerButtonViewModel extends ReactiveViewModel {
  PlayerService _playerService = locator<PlayerService>();
  bool get isPlaying => _playerService.state == PlayerState.playing;
  int get rpm => _playerService.rpm;

  void switchPlayerState() {
    _playerService.switchPlayerState();
    notifyListeners();
  }

  void select33Rpm() {
    _playerService.select33Rpm();
    notifyListeners();
  }

  void select45Rpm() {
    _playerService.select45Rpm();
    notifyListeners();
  }

  void select78Rpm() {
    _playerService.select78Rpm();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
