
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/constants/firestore_collections.dart';
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
        'id': doc.id,
        ...data,
      };
    }).toList());
  }

  Future<void> updateUserItem(String userId, String id, Map<String, dynamic> updatedData) async {
    try {
      isLoading = true;
      final collection = getUserListItems(userId);
      await collection.doc(id).update({
        ...updatedData,
        'updatedAt': FieldValue.serverTimestamp(),
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