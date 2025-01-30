import 'dart:io';

class TempFileManager {
  static final List<File> _tempFiles = [];

  static void registerTempFile(File file) {
    _tempFiles.add(file);
  }

  static void cleanUp() {
    for (var file in _tempFiles) {
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
    _tempFiles.clear();
  }
}
