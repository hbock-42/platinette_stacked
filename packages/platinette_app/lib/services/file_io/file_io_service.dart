import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_picker_service.dart/file_picker_service.dart';
import 'package:stacked/stacked.dart';

import '../main_color_service.dart';
import 'file_io.dart' if (dart.library.html) 'file_io_web.dart';

@lazySingleton
class FileIOService with ReactiveServiceMixin {
  final _mainColorService = locator<MainColorService>();
  FilePickerService _filePickerService = locator<FilePickerService>();

  RxValue<Uint8List> _macaronData = RxValue<Uint8List>(initial: null);
  Uint8List get macaronData => _macaronData.value;

  FileIOService() {
    listenToReactiveValues([_macaronData]);
  }

  Future loadMacaron() async {
    String macaronPath =
        await _filePickerService.chooseFile(extensions: ['png']);
    _macaronData.value = await FileIO.dataFromPath(macaronPath);
    _mainColorService.setMainColorFromImageData(_macaronData.value);
  }
}
