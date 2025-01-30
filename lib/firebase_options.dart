// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions get web {
    return FirebaseOptions(
      apiKey: dotenv.env['WEB_APIKEY']!,
      appId: dotenv.env['WEB_APPID']!,
      messagingSenderId: dotenv.env['WEB_MESSAGINGSENDERID']!,
      projectId: dotenv.env['WEB_PROJECTID']!,
      authDomain: dotenv.env['WEB_AUTHDOMAIN']!,
      storageBucket: dotenv.env['WEB_STORAGEBUCKET']!,
      measurementId: dotenv.env['WEB_MEASUREMENTID']!,
    );
  }

  static FirebaseOptions get android {
    return FirebaseOptions(
      apiKey: dotenv.env['ANDROID_APIKEY']!,
      appId: dotenv.env['ANDROID_APPID']!,
      messagingSenderId: dotenv.env['ANDROID_MESSAGINGSENDERID']!,
      projectId: dotenv.env['ANDROID_PROJECTID']!,
      storageBucket: dotenv.env['ANDROID_STORAGEBUCKET']!,
    );
  }

  static FirebaseOptions get ios {
    return FirebaseOptions(
      apiKey: dotenv.env['IOS_APIKEY']!,
      appId: dotenv.env['IOS_APPID']!,
      messagingSenderId: dotenv.env['IOS_MESSAGINGSENDERID']!,
      projectId: dotenv.env['IOS_PROJECTID']!,
      storageBucket: dotenv.env['IOS_STORAGEBUCKET']!,
      iosBundleId: dotenv.env['IOS_IOSBUNDLEID']!,
    );
  }

  static FirebaseOptions get macos {
    return FirebaseOptions(
      apiKey: dotenv.env['MACOS_APIKEY']!,
      appId: dotenv.env['MACOS_APPID']!,
      messagingSenderId: dotenv.env['MACOS_MESSAGINGSENDERID']!,
      projectId: dotenv.env['MACOS_PROJECTID']!,
      storageBucket: dotenv.env['MACOS_STORAGEBUCKET']!,
      iosBundleId: dotenv.env['MACOS_IOSBUNDLEID']!,
    );
  }

  static FirebaseOptions get windows {
    return FirebaseOptions(
      apiKey: dotenv.env['WINDOWS_APIKEY']!,
      appId: dotenv.env['WINDOWS_APPID']!,
      messagingSenderId: dotenv.env['WINDOWS_MESSAGINGSENDERID']!,
      projectId: dotenv.env['WINDOWS_PROJECTID']!,
      authDomain: dotenv.env['WINDOWS_AUTHDOMAIN']!,
      storageBucket: dotenv.env['WINDOWS_STORAGEBUCKET']!,
      measurementId: dotenv.env['WINDOWS_MEASUREMENTID']!,
    );
  }
}
