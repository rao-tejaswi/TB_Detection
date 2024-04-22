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
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBsDSmoNj5qo4tympDvybVpdpxVdcOh3rA',
    appId: '1:389797856256:web:e8c4c4303c00c73f1784e5',
    messagingSenderId: '389797856256',
    projectId: 'tb-xray',
    authDomain: 'tb-xray.firebaseapp.com',
    storageBucket: 'tb-xray.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCcRi6ypgfKQtrWKPwqyK-ETEHKeq0oFY',
    appId: '1:389797856256:android:4e2bce63f10bce941784e5',
    messagingSenderId: '389797856256',
    projectId: 'tb-xray',
    storageBucket: 'tb-xray.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrrwBhPBsnUc5Ph7MD05etdBIsMMJSNJo',
    appId: '1:389797856256:ios:c42f9433b9c7b9041784e5',
    messagingSenderId: '389797856256',
    projectId: 'tb-xray',
    storageBucket: 'tb-xray.appspot.com',
    iosBundleId: 'com.example.tbXray',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrrwBhPBsnUc5Ph7MD05etdBIsMMJSNJo',
    appId: '1:389797856256:ios:710c23e57b462bc71784e5',
    messagingSenderId: '389797856256',
    projectId: 'tb-xray',
    storageBucket: 'tb-xray.appspot.com',
    iosBundleId: 'com.example.tbXray.RunnerTests',
  );
}