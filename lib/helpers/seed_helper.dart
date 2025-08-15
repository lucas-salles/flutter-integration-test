import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<void> seedDataForE2ETests() async {
  final shouldSeed = await _shouldRunSeed();

  if (!shouldSeed) {
    debugPrint('⚠️ Seed not required. Skipping...');
    return;
  }

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final now = DateTime.now();

  final rawUsers = [
    {'email': 'member1@e2e.com', 'name': 'Membro 1'},
    {'email': 'member2@e2e.com', 'name': 'Membro 2'},
    {'email': 'member3@e2e.com', 'name': 'Membro 3'},
    {'email': 'member4@e2e.com', 'name': 'Membro 4'},
  ];

  for (final raw in rawUsers) {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: raw['email']!,
        password: '123456',
      );

      final uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set({
        'id': uid,
        'email': raw['email'],
        'name': raw['name'],
        'createdAt': now.toIso8601String(),
      });

      debugPrint('✅ User created: ${raw['email']}');
    } catch (e) {
      debugPrint('❌ Error creating user ${raw['email']}: $e');
    }

    await auth.signOut();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  debugPrint('🎉 Seed completed successfully!');
}

Future<bool> _shouldRunSeed() async {
  const useEmulators = bool.fromEnvironment('USE_FIREBASE_EMULATORS');

  final usersQuery = await FirebaseFirestore.instance.collection('users').get();

  return useEmulators && usersQuery.docs.isEmpty;
}
