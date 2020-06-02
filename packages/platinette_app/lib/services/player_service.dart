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

  PlayerService() {
    listenToReactiveValues([_state, _rpm]);
  }

  void switchPlayerState() {
    if (_state.value == PlayerState.playing) {
      pause();
    } else if (_state.value == PlayerState.paused) {
      play();
    }
  }

  void play() {
    print('PlayerService: play');
    _state.value = PlayerState.playing;
  }

  void pause() {
    print('PlayerService: pause');
    _state.value = PlayerState.paused;
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
