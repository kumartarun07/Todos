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
    apiKey: 'AIzaSyCa7rHSyNbOOTVeSk8ZQjA1cRca5HxUcx8',
    appId: '1:212893039984:web:662b2bcdc91720eb6523b5',
    messagingSenderId: '212893039984',
    projectId: 'todos-d1a2b',
    authDomain: 'todos-d1a2b.firebaseapp.com',
    storageBucket: 'todos-d1a2b.firebasestorage.app',
    measurementId: 'G-MP1GK737NN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDP2G_V_kz0sH5nfV0ckCFcjfaOxW6Vr2M',
    appId: '1:212893039984:android:a58505153f4972e56523b5',
    messagingSenderId: '212893039984',
    projectId: 'todos-d1a2b',
    storageBucket: 'todos-d1a2b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMvJR6U0lglIoXgdyL0wTbpx4nG_hx_0I',
    appId: '1:212893039984:ios:b1e316dd0fbe74a26523b5',
    messagingSenderId: '212893039984',
    projectId: 'todos-d1a2b',
    storageBucket: 'todos-d1a2b.firebasestorage.app',
    iosBundleId: 'com.example.todosApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMvJR6U0lglIoXgdyL0wTbpx4nG_hx_0I',
    appId: '1:212893039984:ios:b1e316dd0fbe74a26523b5',
    messagingSenderId: '212893039984',
    projectId: 'todos-d1a2b',
    storageBucket: 'todos-d1a2b.firebasestorage.app',
    iosBundleId: 'com.example.todosApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCa7rHSyNbOOTVeSk8ZQjA1cRca5HxUcx8',
    appId: '1:212893039984:web:8cb1170ae386668b6523b5',
    messagingSenderId: '212893039984',
    projectId: 'todos-d1a2b',
    authDomain: 'todos-d1a2b.firebaseapp.com',
    storageBucket: 'todos-d1a2b.firebasestorage.app',
    measurementId: 'G-4DPG2FDFG7',
  );

}