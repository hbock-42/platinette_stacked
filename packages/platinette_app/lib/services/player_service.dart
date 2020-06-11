import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class PlayerService with ReactiveServiceMixin {
  RxValue<PlayerState> _state =
      RxValue<PlayerState>(initial: PlayerState.paused);
  PlayerState get state => _state.value;

  RxValue<int> _rpm = RxValue<int>(initial: 33);
  int get rpm => _rpm.value;

  RxValue<bool> _recording = RxValue<bool>(initial: false);
  bool get recording => _recording.value;

  PlayerState _stateBeforeRecording;

  PlayerService() {
    listenToReactiveValues([_state, _rpm, _recording]);
  }

  void switchPlayerState() {
    if (_state.value == PlayerState.playing) {
      pause();
    } else if (_state.value == PlayerState.paused) {
      play();
    }
  }

  void play() {
    _state.value = PlayerState.playing;
  }

  void pause() {
    _state.value = PlayerState.paused;
  }

  /// [startRecording] pauses the player and change the player
  /// state to [PlayerState.paused]
  void startRecording() {
    _stateBeforeRecording = _state.value;
    pause();
    _recording.value = true;
  }

  /// [notifyRecordingEnd] should be called at the end of the recording
  void notifyRecordingEnd() {
    if (_stateBeforeRecording == PlayerState.playing) {
      play();
    }
    _recording.value = false;
  }

  void select33Rpm() {
    _selectRpm(33);
  }

  void select45Rpm() {
    _selectRpm(45);
  }

  void select78Rpm() {
    _selectRpm(78);
  }

  void _selectRpm(int rpm) {
    print('selected $rpm rpm');
    _rpm.value = rpm;
  }
}

enum PlayerState {
  playing,
  paused,
}
