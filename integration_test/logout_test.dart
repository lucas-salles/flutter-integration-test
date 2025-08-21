import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_integration_test/app.dart';
import 'package:flutter_integration_test/helpers/seed_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await seedDataForE2ETests();
  });

  group('Logout flow', () {
    testWidgets('logout', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Finds the fields
      final emailField = find.byKey(const ValueKey('emailField'));
      final passwordField = find.byKey(const ValueKey('passwordField'));
      final loginButton = find.byKey(const ValueKey('loginButton'));

      // Ensures that the fields exist
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      // Fill the fiels
      await tester.enterText(emailField, 'member1@e2e.com');
      await tester.enterText(passwordField, '123456');

      // Tap the enter button
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check if navigates to home page
      expect(find.text('Home'), findsOneWidget);

      // Finds the logout button
      final logoutButton = find.byKey(const ValueKey('logoutButton'));

      // Ensures that logout button exists
      expect(logoutButton, findsOneWidget);

      // Tap the logout button
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      // Check if navigates to login page
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
