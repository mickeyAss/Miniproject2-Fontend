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
    apiKey: 'AIzaSyDiKK-KksqJl0M2_Y0qkljvKLOyxctUNpc',
    appId: '1:527562602943:web:bbaf5f37eb26609c99c90a',
    messagingSenderId: '527562602943',
    projectId: 'asdasdada-2d2c0',
    authDomain: 'asdasdada-2d2c0.firebaseapp.com',
    storageBucket: 'asdasdada-2d2c0.appspot.com',
    measurementId: 'G-XKS34MF7EM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCyPbmbCB2UrOuw5neRTUeHJbYK0t3nHk',
    appId: '1:527562602943:android:e8a218f556b1033599c90a',
    messagingSenderId: '527562602943',
    projectId: 'asdasdada-2d2c0',
    storageBucket: 'asdasdada-2d2c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPIzqRFe0-j0QQyfsIKoI2WHN8j4S4aPg',
    appId: '1:527562602943:ios:0baf8c38af21f06699c90a',
    messagingSenderId: '527562602943',
    projectId: 'asdasdada-2d2c0',
    storageBucket: 'asdasdada-2d2c0.appspot.com',
    iosBundleId: 'com.example.fontendMiniproject2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPIzqRFe0-j0QQyfsIKoI2WHN8j4S4aPg',
    appId: '1:527562602943:ios:0baf8c38af21f06699c90a',
    messagingSenderId: '527562602943',
    projectId: 'asdasdada-2d2c0',
    storageBucket: 'asdasdada-2d2c0.appspot.com',
    iosBundleId: 'com.example.fontendMiniproject2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDiKK-KksqJl0M2_Y0qkljvKLOyxctUNpc',
    appId: '1:527562602943:web:06a31a6185c11be499c90a',
    messagingSenderId: '527562602943',
    projectId: 'asdasdada-2d2c0',
    authDomain: 'asdasdada-2d2c0.firebaseapp.com',
    storageBucket: 'asdasdada-2d2c0.appspot.com',
    measurementId: 'G-1R63RF37LY',
  );

}