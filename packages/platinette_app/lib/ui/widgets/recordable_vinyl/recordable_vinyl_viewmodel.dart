import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class RecordableVinylViewModel extends ReactiveViewModel {
  final playerService = locator<PlayerService>();

  int get rpm => playerService.rpm;
  bool get isRecording => playerService.recording;
  bool get isPlaying => playerService.state == PlayerState.playing;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [playerService];
}
