import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'id': uid,
        'email': email,
        'name': name,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('createUser error: $e');
    }
  }

  Future<void> getUsers() async {
    try {
      final userSnapshot = await _firestore.collection('users').get();
      if (userSnapshot.docs.isEmpty) {
        print('No users found');
        return;
      }
      for (var doc in userSnapshot.docs) {
        print('User: ${doc.data()}');
      }
    } catch (e) {
      print('getUsers error: $e');
    }
  }
}
