import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class LoadButtonViewModel extends ReactiveViewModel {
  PlayerService _playerService = locator<PlayerService>();
  bool get isPlaying => _playerService.state == PlayerState.playing;
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
