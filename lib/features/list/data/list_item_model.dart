import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/model/model.dart';
import 'package:normal_list/app/core/services/app_encryption.dart';
import 'package:normal_list/app/core/services/file_handler.dart';

class ListItemModel extends Model {
  
  static final String titleKey = 'title';
  static final String codeKey = 'code';
  static final String urlKey = 'url';
  static final String imageKey = 'image';

  final String title;
  final String code;
  final String? url;
  final File? image;
  final bool hasError;

  // Default constructor
  ListItemModel({
    required super.id,
    required this.code,
    required this.title,
    this.url,
    this.image,
    this.hasError = false,
  });

  // Firebase document constructor
  factory ListItemModel.fromMap(Map<String, dynamic> map) {
    return ListItemModel(
        id: map[Model.idKey] ?? '-',
        code: map[ListItemModel.codeKey],
        title: map[ListItemModel.titleKey],
        url:  map[ListItemModel.urlKey],
    );
  }

    // Firebase document constructor
  factory ListItemModel.insert(String code, String title, String? url, File? image) {
    return ListItemModel(
        id: '-',
        code: code,
        title: title,
        url: url,
        image: image,
    );
  }

  factory ListItemModel.fromMapDecrypted(Map<String, dynamic> map){
    File? image;
    bool hasError = false;
    if(map[ListItemModel.imageKey] != null){
      try {
        final decryptedImageBase64 = AppEncryption.decrypt(map[ListItemModel.imageKey]);
        final imageBytes = base64Decode(decryptedImageBase64);
        image = FileHandler.writeFileFromBase64(imageBytes);
      } catch (e) {
        image = null;
        hasError = true;
      }
    }
    return ListItemModel(
        id: map[Model.idKey] ?? '-',
        code: AppEncryption.decrypt(map[ListItemModel.codeKey]),
        title: AppEncryption.decrypt(map[ListItemModel.titleKey]),
        url:  AppEncryption.decrypt(map[ListItemModel.urlKey]),
        image: image,
        hasError: hasError,
    );
  }

  Map<String, dynamic> insertToMap(){
    return {
      ListItemModel.codeKey: code,
      ListItemModel.titleKey: title,
      ListItemModel.urlKey: url,
      ListItemModel.imageKey: image,
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> insertToMapEncrypted(){
    String? encryptedImageBase64;
    if(image != null){
      final imageBase64 = FileHandler.readBase64FromFile(image!);
      encryptedImageBase64 = AppEncryption.encrypt(imageBase64);
    }
    return {
      ListItemModel.codeKey: AppEncryption.encrypt(code),
      ListItemModel.titleKey: AppEncryption.encrypt(title),
      ListItemModel.urlKey: AppEncryption.encrypt(url),
      ListItemModel.imageKey: encryptedImageBase64,
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }

  Future<Map<String, dynamic>> insertToMapEncryptedAsync() async {
    String? encryptedImageBase64;
    if(image != null){
      final imageBase64 = FileHandler.readBase64FromFile(image!);
      encryptedImageBase64 = AppEncryption.encrypt(imageBase64);
    }
    return {
      ListItemModel.codeKey: AppEncryption.encrypt(code),
      ListItemModel.titleKey: AppEncryption.encrypt(title),
      ListItemModel.urlKey: AppEncryption.encrypt(url),
      ListItemModel.imageKey: encryptedImageBase64,
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }
}