
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:normal_list/app/core/constants/firestore_collections.dart';

class ListService {
  
  CollectionReference getUserListItems(String userId) {
    return FirebaseFirestore.instance.collection(FirestoreCollections.list).doc(userId).collection(FirestoreCollections.listItems);
  }

  Future<void> addUserItem(String userId, String title, String code ) async {
    try {
      final collection = getUserListItems(userId);
      await collection.add({
        'title': title,
        'code': code,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add new item: $e');
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
      final collection = getUserListItems(userId);
      await collection.doc(id).update(updatedData);
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  Future<void> deleteUserItem(String userId, String id) async {
    try {
      final collection = getUserListItems(userId);
      collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }
}