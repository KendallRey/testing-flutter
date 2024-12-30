import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/model/model.dart';
import 'package:normal_list/app/core/services/app_encryption.dart';

class ListItemModel extends Model {
  
  static final String titleKey = 'title';
  static final String codeKey = 'code';
  static final String urlKey = 'url';

  final String title;
  final String code;
  final String? url;

  // Default constructor
  ListItemModel({
    required super.id,
    required this.code,
    required this.title,
    this.url,
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
  factory ListItemModel.insert(String code, String title, String? url) {
    return ListItemModel(
        id: '-',
        code: code,
        title: title,
        url: url,
    );
  }

  factory ListItemModel.fromMapDecrypted(Map<String, dynamic> map){
    return ListItemModel(
        id: map[Model.idKey] ?? '-',
        code: AppEncryption.decrypt(map[ListItemModel.codeKey]),
        title: AppEncryption.decrypt(map[ListItemModel.titleKey]),
        url:  AppEncryption.decrypt(map[ListItemModel.urlKey]),
    );
  }

  Map<String, dynamic> insertToMap(){
    return {
      ListItemModel.codeKey: code,
      ListItemModel.titleKey: title,
      ListItemModel.urlKey: url,
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> insertToMapEncrypted(){
    return {
      ListItemModel.codeKey: AppEncryption.encrypt(code),
      ListItemModel.titleKey: AppEncryption.encrypt(title),
      ListItemModel.urlKey: AppEncryption.encrypt(url),
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }
}