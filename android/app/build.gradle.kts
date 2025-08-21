import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val devKeystoreProperties = Properties()
val devKeystorePropertiesFile = rootProject.file("dev-key.properties")
if (devKeystorePropertiesFile.exists()) {
    devKeystoreProperties.load(FileInputStream(devKeystorePropertiesFile))
}

val prodKeystoreProperties = Properties()
val prodKeystorePropertiesFile = rootProject.file("prod-key.properties")
if (prodKeystorePropertiesFile.exists()) {
    prodKeystoreProperties.load(FileInputStream(prodKeystorePropertiesFile))
}

android {
    namespace = "com.lucassales.flutter_integration_test"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.lucassales.flutter_integration_test"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        getByName("debug") {
            storeFile = file("../debug-keystore.jks")
            keyAlias = "debug"
            keyPassword = "debugpassword"
            storePassword = "debugpassword"
        }
        create("dev") {
            keyAlias = devKeystoreProperties["keyAlias"] as String
            keyPassword = devKeystoreProperties["keyPassword"] as String
            storeFile = devKeystoreProperties["storeFile"]?.let { file(it) }
            storePassword = devKeystoreProperties["storePassword"] as String
        }
        create("prod") {
            keyAlias = prodKeystoreProperties["keyAlias"] as String
            keyPassword = prodKeystoreProperties["keyPassword"] as String
            storeFile = prodKeystoreProperties["storeFile"]?.let { file(it) }
            storePassword = prodKeystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            //signingConfig = signingConfigs.getByName("release")
        }
    }

    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            resValue(type = "string", name = "app_name", value = "Flutter Integration Dev")
            signingConfig = signingConfigs.getByName("dev")
        }
        create("prod") {
            dimension = "default"
            resValue(type = "string", name = "app_name", value = "Flutter Integration")
            signingConfig = signingConfigs.getByName("prod")
        }
    }
}

flutter {
    source = "../.."
}
