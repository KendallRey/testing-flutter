import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/model/model.dart';

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
        code: map[ListItemModel.codeKey] ?? '-',
        title: map[ListItemModel.titleKey] ?? '-',
        url: map[ListItemModel.urlKey],
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

  Map<String, dynamic> insertToMap(){
    return {
      ListItemModel.codeKey: code,
      ListItemModel.titleKey: title,
      ListItemModel.urlKey: url,
      Model.createdAtKey: FieldValue.serverTimestamp(),
      Model.updatedAtKey: FieldValue.serverTimestamp(),
    };
  }
}