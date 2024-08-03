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
    apiKey: 'AIzaSyCfXY4LidEbBkwvA5lYM8jFBH08KxRC69c',
    appId: '1:764070526715:web:7d91237017d9122a49fa5e',
    messagingSenderId: '764070526715',
    projectId: 'bootcampdatabase-9b4d5',
    authDomain: 'bootcampdatabase-9b4d5.firebaseapp.com',
    storageBucket: 'bootcampdatabase-9b4d5.appspot.com',
    measurementId: 'G-6N34LNKZFB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAt1cGdIhOkX-Fkd83CadmFtHgm6mYgFYA',
    appId: '1:764070526715:android:2863a09e464d24ba49fa5e',
    messagingSenderId: '764070526715',
    projectId: 'bootcampdatabase-9b4d5',
    storageBucket: 'bootcampdatabase-9b4d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDHMOF2Csy9uv3HYv5ooO7xrrob_m-skY',
    appId: '1:764070526715:ios:24c45f72f409d24a49fa5e',
    messagingSenderId: '764070526715',
    projectId: 'bootcampdatabase-9b4d5',
    storageBucket: 'bootcampdatabase-9b4d5.appspot.com',
    iosBundleId: 'com.example.flutterUpgrdeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDHMOF2Csy9uv3HYv5ooO7xrrob_m-skY',
    appId: '1:764070526715:ios:24c45f72f409d24a49fa5e',
    messagingSenderId: '764070526715',
    projectId: 'bootcampdatabase-9b4d5',
    storageBucket: 'bootcampdatabase-9b4d5.appspot.com',
    iosBundleId: 'com.example.flutterUpgrdeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfXY4LidEbBkwvA5lYM8jFBH08KxRC69c',
    appId: '1:764070526715:web:beb59e87aff2f7de49fa5e',
    messagingSenderId: '764070526715',
    projectId: 'bootcampdatabase-9b4d5',
    authDomain: 'bootcampdatabase-9b4d5.firebaseapp.com',
    storageBucket: 'bootcampdatabase-9b4d5.appspot.com',
    measurementId: 'G-XNHG1KZNPL',
  );

}