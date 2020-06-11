import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/animation_recorder_service/animation_recorder_service.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';
import 'package:image/image.dart';

class RecordableVinylViewModel extends ReactiveViewModel {
  final _playerService = locator<PlayerService>();
  final _animationRecorderService = locator<AnimationRecorderService>();

  int get rpm => _playerService.rpm;
  bool get isRecording => _playerService.recording;
  bool get isPlaying => _playerService.state == PlayerState.playing;

  void saveAnimation(Animation animation) {
    _animationRecorderService.saveAnimation(animation);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
