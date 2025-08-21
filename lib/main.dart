import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;
import 'flavors.dart';
import 'helpers/seed_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flavor.appFlavor = switch (appFlavor) {
    'prod' => Flavors.prod,
    'dev' => Flavors.dev,
    _ => throw UnsupportedError('Invalid flavor: $appFlavor'),
  };
  final firebaseOptions = switch (Flavor.appFlavor) {
    Flavors.prod => prod.DefaultFirebaseOptions.currentPlatform,
    Flavors.dev => dev.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(options: firebaseOptions);
  await _configureFirebaseForTesting();
  runApp(const MyApp());
}

Future<void> _configureFirebaseForTesting() async {
  const useEmulators = bool.fromEnvironment('USE_FIREBASE_EMULATORS');

  if (useEmulators) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await seedDataForE2ETests();
  }
}
