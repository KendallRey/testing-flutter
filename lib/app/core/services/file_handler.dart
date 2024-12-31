import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:normal_list/app/core/services/temp_file_manager.dart';

class FileHandler {

  static String getFileExtensionFromBase64(){
    return '';
  }

  static File writeFileFromBase64(Uint8List imageBytes) {
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.png');
    TempFileManager.registerTempFile(tempFile);
    tempFile.writeAsBytesSync(imageBytes);
    return tempFile;
  }

  static Future<File> writeFileFromBase64Async (Uint8List imageBytes) async {
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.png');
    TempFileManager.registerTempFile(tempFile);
    await tempFile.writeAsBytes(imageBytes);
    return tempFile;
  }

  static String readBase64FromFile(File file) {
    
    final fileBytes = file.readAsBytesSync();
    String imageBase64 = base64Encode(fileBytes);
    return imageBase64;
  }

  // String webReadBase64FromFile(File file) {
  //   final reader = FileReader();
  //   final completer = Completer<String>();

  //   // Read file as an ArrayBuffer
  //   reader.onLoadEnd.listen((_) {
  //     final Uint8List fileBytes = reader.result as Uint8List;
  //     final base64String = base64Encode(fileBytes);
  //     completer.complete(base64String);
  //   });

  //   reader.onError.listen((error) {
  //     completer.completeError('Failed to read file: $error');
  //   });

  //   reader.readAsArrayBuffer(webFile);

  //   return completer.future;
  // }

  static Future<String> readBase64FromFileAsync(File file) async {
    final fileBytes = await file.readAsBytes();
    String imageBase64 = base64Encode(fileBytes);
    return imageBase64;
  }

}