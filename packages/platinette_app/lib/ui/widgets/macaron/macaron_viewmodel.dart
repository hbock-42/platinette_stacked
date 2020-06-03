import 'dart:typed_data';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_io/file_io_service.dart';
import 'package:stacked/stacked.dart';

class MacaronViewModel extends ReactiveViewModel {
  FileIOService _fileIOService = locator<FileIOService>();

  Uint8List get macaronData => _fileIOService.macaronData;
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_fileIOService];
}
