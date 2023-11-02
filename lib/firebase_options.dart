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
    apiKey: 'AIzaSyA4EA3F09ZcBymMVO8gK1mFKsrntGI8Sxw',
    appId: '1:466228417636:web:7ab90ebb90fc44981dbb71',
    messagingSenderId: '466228417636',
    projectId: 'xemphim-19175',
    authDomain: 'xemphim-19175.firebaseapp.com',
    storageBucket: 'xemphim-19175.appspot.com',
    measurementId: 'G-WLH0122J25',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0pLUIsPrZ9TbcoSBjE_oiSLygTclyFAY',
    appId: '1:466228417636:android:81ba6c4a67d021651dbb71',
    messagingSenderId: '466228417636',
    projectId: 'xemphim-19175',
    storageBucket: 'xemphim-19175.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9bikY6mzDm0Ut61JJWXXTJqZ9YRLnKFg',
    appId: '1:466228417636:ios:a316c55a7aa0db831dbb71',
    messagingSenderId: '466228417636',
    projectId: 'xemphim-19175',
    storageBucket: 'xemphim-19175.appspot.com',
    iosBundleId: 'com.example.baitap08',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9bikY6mzDm0Ut61JJWXXTJqZ9YRLnKFg',
    appId: '1:466228417636:ios:7572390fc5ddf7e21dbb71',
    messagingSenderId: '466228417636',
    projectId: 'xemphim-19175',
    storageBucket: 'xemphim-19175.appspot.com',
    iosBundleId: 'com.example.baitap08.RunnerTests',
  );
}
