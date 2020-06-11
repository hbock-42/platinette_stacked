import 'package:injectable/injectable.dart';
import 'package:image/image.dart';
import 'package:platinette_app/app/locator.dart';
import 'package:platinette_app/services/file_picker_service.dart/file_picker_service.dart';

@lazySingleton
class AnimationRecorderService {
  final _filePickerService = locator<FilePickerService>();

  Future saveAnimation(Animation animation) async {
    List<int> encodedAnimation = encodePngAnimation(animation);
    _filePickerService.getSavePath();
    // File(result.paths.first)..writeAsBytesSync(encodedAnimation);
  }
}
