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

  group('Counter flow', () {
    testWidgets('tap on the floating action button, verify counter', (
      tester,
    ) async {
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

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final fab = find.byKey(const ValueKey('increment'));

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
    });
  });
}
