import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final user = auth.currentUser;
    if (user == null) throw FirebaseException(plugin: 'auth', message: 'Not authenticated');

    final payload = Map<String, dynamic>.from(data);
    payload['updatedAt'] = FieldValue.serverTimestamp();

    await db.collection('users').doc(user.uid).set(payload, SetOptions(merge: true));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() async {
    final user = auth.currentUser;
    if (user == null) throw FirebaseException(plugin: 'auth', message: 'Not authenticated');
    return db.collection('users').doc(user.uid).get();
  }

  Future<DocumentReference> addTask(Map<String, dynamic> task) async {
    final user = auth.currentUser;
    if (user == null) throw FirebaseException(plugin: 'auth', message: 'Not authenticated');

    final payload = Map<String, dynamic>.from(task);
    payload['owner'] = user.uid;
    payload['createdAt'] = FieldValue.serverTimestamp();

    return db.collection('tasks').add(payload);
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    final user = auth.currentUser;
    if (user == null) throw FirebaseException(plugin: 'auth', message: 'Not authenticated');

    final docRef = db.collection('tasks').doc(taskId);
    final snapshot = await docRef.get();
    final data = snapshot.data();
    if (data == null) throw FirebaseException(plugin: 'firestore', message: 'Task not found');

    // Security rules also enforce owner/admin checks; this is a client-side guard
    if (data['owner'] != user.uid) {
      throw FirebaseException(plugin: 'auth', message: 'Not task owner');
    }

    updates['updatedAt'] = FieldValue.serverTimestamp();
    await docRef.update(updates);
  }
}
