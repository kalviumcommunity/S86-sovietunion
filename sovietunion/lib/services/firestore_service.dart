import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();

  static CollectionReference<Map<String, dynamic>> _itemsRef(String uid) =>
      FirebaseFirestore.instance.collection('users').doc(uid).collection('items');

  static Stream<QuerySnapshot<Map<String, dynamic>>> streamItems(String uid) {
    return _itemsRef(uid).orderBy('createdAt', descending: true).snapshots();
  }

  static Future<void> createItem(String title, String description) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not signed in');

    await _itemsRef(uid).add({
      'title': title,
      'description': description,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> updateItem(String id, Map<String, dynamic> updates) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not signed in');

    await _itemsRef(uid).doc(id).update({
      ...updates,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> deleteItem(String id) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not signed in');

    await _itemsRef(uid).doc(id).delete();
  }
}
