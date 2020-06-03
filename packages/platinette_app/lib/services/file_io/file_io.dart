import 'dart:io';
import 'dart:typed_data';

class FileIO {
  static Future<Uint8List> dataFromPath(String path) async =>
      await File(path).readAsBytes();
}
