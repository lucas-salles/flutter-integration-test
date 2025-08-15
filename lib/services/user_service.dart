import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      debugPrint('createUser error: $e');
    }
  }
}
