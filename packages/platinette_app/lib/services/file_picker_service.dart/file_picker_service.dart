import 'package:injectable/injectable.dart';

import 'file_picker_web.dart' if (dart.library.io) 'file_picker.dart';

@lazySingleton
class FilePickerService extends FilePicker {}
