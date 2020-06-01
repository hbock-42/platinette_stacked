import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class PlayerService with ReactiveServiceMixin {
  RxValue<PlayerState> _state =
      RxValue<PlayerState>(initial: PlayerState.paused);
  PlayerState get state => _state.value;

  PlayerService() {
    listenToReactiveValues([_state]);
  }

  void switchPlayerState() {
    print("PlayerService: switchPlayerState");
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
}

enum PlayerState {
  playing,
  paused,
}
