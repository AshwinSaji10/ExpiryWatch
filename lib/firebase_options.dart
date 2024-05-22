// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBA8HvsK_tHQEeQIp8Ht0fjijctPehH9PY',
    appId: '1:58931858564:web:8d1dc0f7590c3f618706d1',
    messagingSenderId: '58931858564',
    projectId: 'expirydatetracker-712ac',
    authDomain: 'expirydatetracker-712ac.firebaseapp.com',
    storageBucket: 'expirydatetracker-712ac.appspot.com',
    measurementId: 'G-D8C73KPYX9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMqgBFPA4YY_yoQWBbaIFaVxMPmcxFHyI',
    appId: '1:58931858564:android:e4c6b66e47249d778706d1',
    messagingSenderId: '58931858564',
    projectId: 'expirydatetracker-712ac',
    storageBucket: 'expirydatetracker-712ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDnuCkXjbzY1YLhY5xT2JwHBWMA9WqOrU',
    appId: '1:58931858564:ios:b515eeb9450077998706d1',
    messagingSenderId: '58931858564',
    projectId: 'expirydatetracker-712ac',
    storageBucket: 'expirydatetracker-712ac.appspot.com',
    iosBundleId: 'com.example.expiryDateTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDnuCkXjbzY1YLhY5xT2JwHBWMA9WqOrU',
    appId: '1:58931858564:ios:b515eeb9450077998706d1',
    messagingSenderId: '58931858564',
    projectId: 'expirydatetracker-712ac',
    storageBucket: 'expirydatetracker-712ac.appspot.com',
    iosBundleId: 'com.example.expiryDateTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBA8HvsK_tHQEeQIp8Ht0fjijctPehH9PY',
    appId: '1:58931858564:web:44cf0b79895ccad08706d1',
    messagingSenderId: '58931858564',
    projectId: 'expirydatetracker-712ac',
    authDomain: 'expirydatetracker-712ac.firebaseapp.com',
    storageBucket: 'expirydatetracker-712ac.appspot.com',
    measurementId: 'G-NC9L3C0E6T',
  );

}