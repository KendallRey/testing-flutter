
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/constants/firestore_collections.dart';
import 'package:normal_list/app/core/model/model.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';

class ListService {
  
  CollectionReference getUserListItems(String userId) {
    return FirebaseFirestore.instance.collection(FirestoreCollections.list).doc(userId).collection(FirestoreCollections.listItems);
  }

  static bool isLoading = false;

  Future<void> addUserItem(String userId, ListItemModel payload ) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      await Future.delayed(Duration(seconds: 4));
      await collection.add(payload.insertToMap());
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

  Future<ListItemModel?> fetchUserItem(String userId, String id) async {
    try {
      isLoading = true;
      final documentReference = getUserListItems(userId).doc(id);
      final document = await documentReference.get();
      return ListItemModel.fromMap(document.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
    finally {
      isLoading = false;
    }
  }

  Future<void> updateUserItem(String userId, String id, Map<String, dynamic> updatedData) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      await collection.doc(id).update({
        ...updatedData,
        Model.updatedAtKey : FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
    finally {
      isLoading = false;
    }
  }

  Future<void> deleteUserItem(String userId, String id) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
    finally {
      isLoading = false;
    }
  }
}