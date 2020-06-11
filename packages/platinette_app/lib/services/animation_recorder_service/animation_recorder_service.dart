import 'package:injectable/injectable.dart';
import 'package:image/image.dart';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_io/file_io_service.dart';
import 'package:platinette_app/services/file_picker_service.dart/file_picker_service.dart';

@lazySingleton
class AnimationRecorderService {
  final _filePickerService = locator<FilePickerService>();
  final _fileIOService = locator<FileIOService>();

  Future saveAnimation(Animation animation) async {
    List<int> encodedAnimation = encodePngAnimation(animation);
    final savePath = await _filePickerService.getSavePath();
    if (savePath != null && savePath.isNotEmpty) {
      _fileIOService.saveBytesAsync(encodedAnimation, savePath);
    }
  }
}
