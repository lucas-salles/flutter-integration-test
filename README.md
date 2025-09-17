# flutter_integration_test

A new Flutter project.

## 🏗️ Development & Build

- **Run (Development)**

```sh
flutter run --flavor dev
```

- **Run (Production)**

```sh
flutter run --flavor prod
```

- **Build APK / App Bundle (Development)**

```sh
flutter build apk --flavor dev
flutter build appbundle --flavor dev
```

- **Build APK / App Bundle (Production)**

```sh
flutter build apk --flavor prod
flutter build appbundle --flavor prod
```

- **Build Web (Development)**

```sh
flutter build web --release --dart-define=APP_ENV=dev
```

- **Build Web (Production)**

```sh
flutter build web --release --dart-define=APP_ENV=prod
```