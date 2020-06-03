// import 'dart:html' if (dart.library.io) 'dart:io';
import 'dart:html';
// import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_picker_service.dart/file_picker_service.dart';
import 'package:stacked/stacked.dart';

// not done
@lazySingleton
class FileProvider with ReactiveServiceMixin {
  FilePickerService _filePickerService = locator<FilePickerService>();

  RxValue<File> _macaronFile = RxValue<File>(initial: null);
  File get macaronFile => _macaronFile.value;

  FileProvider() {
    listenToReactiveValues([_macaronFile]);
  }

  Future loadMacaron() async {
    String macaronPath = await _filePickerService.chooseFile();
    // _macaronFile.value = File(macaronPath);
  }

  void pause() {
    print('PlayerService: pause');
    // _state.value = PlayerState.paused;
  }

  // void _selectRpm(int rpm) {
  //   print('selected $rpm rpm');
  //   _rpm.value = rpm;
  // }
}

enum PlayerState {
  playing,
  paused,
}
