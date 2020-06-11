import 'dart:io';
import 'dart:typed_data';

class FileIO {
  static Future<Uint8List> dataFromPath(String path) async {
    Uint8List fileData;
    try {
      fileData = await File(path).readAsBytes();
    } catch (ex) {
      print('FileIO in file_io.dart, dataFromPath, exception: $ex');
      fileData = null;
    }
    return fileData;
  }

  static Future saveBytesAsync(List<int> bytes, String path) async {
    try {
      var file = File(path);
      await file.writeAsBytes(bytes);
    } catch (ex) {
      print('FileIO in file_io.dart, saveBytesAsync, exception: $ex');
    }
  }
}
