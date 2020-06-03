import 'package:file_chooser/file_chooser.dart';

Future<String> chooseFile({List<String> extensions}) async {
  print('in choose file desktop, file extensions: $extensions');
  FileChooserResult chooserResult = await showOpenPanel(
    allowedFileTypes: extensions == null
        ? null
        : [FileTypeFilterGroup(fileExtensions: extensions)],
  );
  return chooserResult.canceled ? null : chooserResult.paths.first;
}

Future<String> getSavePath({List<String> extensions}) async {
  FileChooserResult chooserResult = await showSavePanel(
    allowedFileTypes: extensions == null
        ? null
        : [FileTypeFilterGroup(fileExtensions: extensions)],
  );
  return chooserResult.canceled ? null : chooserResult.paths.first;
}
