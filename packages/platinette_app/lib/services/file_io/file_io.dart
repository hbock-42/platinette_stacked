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
}
