import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_io/file_io_service.dart';
import 'package:stacked/stacked.dart';

class GetFileButtonViewModel extends BaseViewModel {
  FileIOService _fileIOService = locator<FileIOService>();

  void loadMacaron() => _fileIOService.loadMacaron();
}
