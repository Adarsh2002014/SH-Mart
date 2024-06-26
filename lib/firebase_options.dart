// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuLqGbP09jHh25OtMHrwv2jerP-P5UFvU',
    appId: '1:1097358141827:web:f933924778ce387d62eeb6',
    messagingSenderId: '1097358141827',
    projectId: 'shmart-15083',
    authDomain: 'shmart-15083.firebaseapp.com',
    storageBucket: 'shmart-15083.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwadPaeydkt2Ca59ERZDPQ0VDxyTrcflQ',
    appId: '1:1097358141827:android:6bbabe6a92927a0a62eeb6',
    messagingSenderId: '1097358141827',
    projectId: 'shmart-15083',
    storageBucket: 'shmart-15083.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1gZPKNQtPtq4Q-5p48zafJ_3GMIUCT1w',
    appId: '1:1097358141827:ios:9be80ecf9c925c9662eeb6',
    messagingSenderId: '1097358141827',
    projectId: 'shmart-15083',
    storageBucket: 'shmart-15083.appspot.com',
    iosBundleId: 'com.example.shmart',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCuLqGbP09jHh25OtMHrwv2jerP-P5UFvU',
    appId: '1:1097358141827:web:f8283754213bf0da62eeb6',
    messagingSenderId: '1097358141827',
    projectId: 'shmart-15083',
    authDomain: 'shmart-15083.firebaseapp.com',
    storageBucket: 'shmart-15083.appspot.com',
  );

}