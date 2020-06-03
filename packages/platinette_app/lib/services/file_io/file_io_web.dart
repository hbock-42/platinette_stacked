import 'dart:typed_data';

class FileIO {
  static Future<Uint8List> dataFromPath(String path) => throw UnsupportedError(
      'FileProvider.dataFromPath is only supported where dart:io is available.');
}
