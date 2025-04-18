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
    apiKey: 'AIzaSyAuCNuvG-dm1FbDgGu_wMuBr2w3sR5jzqk',
    appId: '1:733530291066:web:71cf4071f358e6f1f774c3',
    messagingSenderId: '733530291066',
    projectId: 'flutter-firebase-template-4900',
    authDomain: 'flutter-firebase-template-4900.firebaseapp.com',
    storageBucket: 'flutter-firebase-template-4900.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFkv7WC1H3I2mwKfcUIKMmiVeoekTdwwg',
    appId: '1:733530291066:android:f95bf8d3c3a3cd0df774c3',
    messagingSenderId: '733530291066',
    projectId: 'flutter-firebase-template-4900',
    storageBucket: 'flutter-firebase-template-4900.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCA5rdFiMvvcm0htej0ktkXVK1NRwC70ow',
    appId: '1:733530291066:ios:207af52479604862f774c3',
    messagingSenderId: '733530291066',
    projectId: 'flutter-firebase-template-4900',
    storageBucket: 'flutter-firebase-template-4900.firebasestorage.app',
    iosBundleId: 'com.example.flutterTemplate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCA5rdFiMvvcm0htej0ktkXVK1NRwC70ow',
    appId: '1:733530291066:ios:207af52479604862f774c3',
    messagingSenderId: '733530291066',
    projectId: 'flutter-firebase-template-4900',
    storageBucket: 'flutter-firebase-template-4900.firebasestorage.app',
    iosBundleId: 'com.example.flutterTemplate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAuCNuvG-dm1FbDgGu_wMuBr2w3sR5jzqk',
    appId: '1:733530291066:web:fb0817f3bcf47978f774c3',
    messagingSenderId: '733530291066',
    projectId: 'flutter-firebase-template-4900',
    authDomain: 'flutter-firebase-template-4900.firebaseapp.com',
    storageBucket: 'flutter-firebase-template-4900.firebasestorage.app',
  );

}