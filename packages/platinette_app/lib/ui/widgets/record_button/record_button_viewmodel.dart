import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class RecordButtonViewModel extends BaseViewModel {
  final _playerService = locator<PlayerService>();

  bool get isPlaying => _playerService.state == PlayerState.playing;

  void startRecording() => _playerService.startRecording();
}
