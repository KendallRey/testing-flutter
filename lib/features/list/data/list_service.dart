
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:normal_list/app/core/constants/firestore_collections.dart';
import 'package:normal_list/app/core/model/model.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';

class ListService {
  
  CollectionReference getUserListItems(String userId) {
    return FirebaseFirestore.instance.collection(FirestoreCollections.list).doc(userId).collection(FirestoreCollections.listItems);
  }

  static bool isLoading = false;

  Future<void> addUserItem(String userId, ListItemModel item) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      final payload = await item.insertToMapEncryptedAsync();
      await collection.add(payload);
    } catch (e) {
      throw Exception('Failed to add new item: $e');
    } 
    finally {
      isLoading = false;
    }
  }

  Stream<List<Map<String, dynamic>>> getUserItems(String userId) {
    final collection = getUserListItems(userId);
    return collection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        Model.idKey: doc.id,
        ...data,
      };
    }).toList());
  }

  Stream<List<ListItemModel>> getUserItemsDecrypted(String userId) {
    final collection = getUserListItems(userId);
    return collection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ListItemModel.fromMapDecrypted({
        Model.idKey: doc.id,
          ...data,
        });
    }).toList());
  }

  Stream<ListItemModel?> getUserItem(String userId, String id) {
    final documentReference = getUserListItems(userId).doc(id);
    return documentReference.snapshots().map((snapshot) {
      if(snapshot.exists){
        return ListItemModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      else {
        return null;
      }
    }).handleError((error) {
      return null;
    });
  }

  Stream<ListItemModel?> getUserItemDecrypted(String userId, String id) {
    final documentReference = getUserListItems(userId).doc(id);
    return documentReference.snapshots().map((snapshot) {
      if(snapshot.exists){
        return ListItemModel.fromMapDecrypted({
          Model.idKey: snapshot.id,
          ...snapshot.data() as Map<String, dynamic>
        });
      }
      else {
        return null;
      }
    }).handleError((error) {
      return null;
    });
  }

  Future<ListItemModel?> fetchUserItem(String userId, String id) async {
    try {
      isLoading = true;
      final documentReference = getUserListItems(userId).doc(id);
      final document = await documentReference.get();
      return ListItemModel.fromMapDecrypted(document.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
    finally {
      isLoading = false;
    }
  }

  Future<void> updateUserItem(String userId,  String id, ListItemModel item) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      final payload = await item.insertToMapEncryptedAsync();
      await collection.doc(id).update({
        ...payload,
        Model.updatedAtKey : FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add new item: $e');
    }
    finally {
      isLoading = false;
    }
  }

  Future<bool> deleteUserItem(String userId, String id) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      await collection.doc(id).delete();
      if(kDebugMode) {
        print('Delete item called: $id');
      }
      return true;
    } catch (e) {
      if(kDebugMode) {
        print('Failed to delete item: $e');
      }
      return false;
    }
    finally {
      isLoading = false;
    }
  }
}