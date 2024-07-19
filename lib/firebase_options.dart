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
    apiKey: 'AIzaSyAEeIJnSUC_ZBcibh3Z-YqLBqs8raX_jfc',
    appId: '1:89066243062:web:275060a7adf053f1b23dd7',
    messagingSenderId: '89066243062',
    projectId: 'intellitutor-7fa89',
    authDomain: 'intellitutor-7fa89.firebaseapp.com',
    storageBucket: 'intellitutor-7fa89.appspot.com',
    measurementId: 'G-7KS09GMSP8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbJbYJ-L_86HaeWm83DN3Ct5tnG5UQvWs',
    appId: '1:89066243062:android:7cdb68428dadac5fb23dd7',
    messagingSenderId: '89066243062',
    projectId: 'intellitutor-7fa89',
    storageBucket: 'intellitutor-7fa89.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6E2hN6QbEZD6XXkpMuPGOg2aYjS-Hnq0',
    appId: '1:89066243062:ios:38b0985a45d7250db23dd7',
    messagingSenderId: '89066243062',
    projectId: 'intellitutor-7fa89',
    storageBucket: 'intellitutor-7fa89.appspot.com',
    iosClientId: '89066243062-f9mdm7f1h6hsvq5k062qf0ed5cfp9sfk.apps.googleusercontent.com',
    iosBundleId: 'com.example.intellitutor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6E2hN6QbEZD6XXkpMuPGOg2aYjS-Hnq0',
    appId: '1:89066243062:ios:38b0985a45d7250db23dd7',
    messagingSenderId: '89066243062',
    projectId: 'intellitutor-7fa89',
    storageBucket: 'intellitutor-7fa89.appspot.com',
    iosClientId: '89066243062-f9mdm7f1h6hsvq5k062qf0ed5cfp9sfk.apps.googleusercontent.com',
    iosBundleId: 'com.example.intellitutor',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAEeIJnSUC_ZBcibh3Z-YqLBqs8raX_jfc',
    appId: '1:89066243062:web:d2e46a2c60ce6a5cb23dd7',
    messagingSenderId: '89066243062',
    projectId: 'intellitutor-7fa89',
    authDomain: 'intellitutor-7fa89.firebaseapp.com',
    storageBucket: 'intellitutor-7fa89.appspot.com',
    measurementId: 'G-BMTJFDNZG4',
  );
}