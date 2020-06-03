import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_io/file_io_service.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:stacked/stacked.dart';

class GetFileButtonViewModel extends ReactiveViewModel {
  final _fileIOService = locator<FileIOService>();
  final _playerService = locator<PlayerService>();

  bool get isPlaying => _playerService.state == PlayerState.playing;

  void loadMacaron() => _fileIOService.loadMacaron();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_playerService];
}
