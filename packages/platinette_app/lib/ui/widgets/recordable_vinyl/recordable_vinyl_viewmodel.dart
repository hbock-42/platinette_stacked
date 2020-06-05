import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:platinette_app/services/screenshot_animator_service/screenshot_animator_service.dart';
import 'package:stacked/stacked.dart';

class RecordableVinylViewModel extends ReactiveViewModel {
  final _playerService = locator<PlayerService>();
  final _screenshotAnimatorService = locator<ScreenshotAnimatorService>();

  int get rpm => _playerService.rpm;
  bool get isRecording => _playerService.recording;
  bool get isPlaying => _playerService.state == PlayerState.playing;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
