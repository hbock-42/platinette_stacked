import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final _playerService = locator<PlayerService>();
  PlayerState get playerState => _playerService.state;

  void switchPlayerState() {
    _playerService.switchPlayerState();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
