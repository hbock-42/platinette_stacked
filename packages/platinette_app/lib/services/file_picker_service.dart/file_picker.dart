import 'dart:io';
import 'file_picker_desktop.dart' as desktop;

class FilePicker {
  Future<String> chooseFile({List<String> extensions}) async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return desktop.chooseFile(extensions: extensions);
    } else {
      throw UnsupportedError(
          'FilePickerService.chooseFile is only supported for desktop.');
    }
  }

  Future<String> getSavePath({List<String> extensions}) async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return desktop.getSavePath(extensions: extensions);
    } else {
      throw UnsupportedError(
          'FilePickerService.getSavePath is only supported for desktop.');
    }
  }
}
