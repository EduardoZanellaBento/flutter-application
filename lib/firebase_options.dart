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
    apiKey: 'AIzaSyD5pfcrhEh8z04iCLeeL3-40IM_5Lmzmos',
    appId: '1:117330271520:web:c8dbc3f4cfdb2156f98b45',
    messagingSenderId: '117330271520',
    projectId: 'flutter-aplication-teste',
    authDomain: 'flutter-aplication-teste.firebaseapp.com',
    storageBucket: 'flutter-aplication-teste.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCX8_qAPiLcshd2LSuMs1ZLIorb6qUGjbs',
    appId: '1:117330271520:android:a2e578e615ff5e78f98b45',
    messagingSenderId: '117330271520',
    projectId: 'flutter-aplication-teste',
    storageBucket: 'flutter-aplication-teste.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBc-lLpYFgpPJygwD8gHlXg5tr5GqEDrxU',
    appId: '1:117330271520:ios:759ba3e797afaea8f98b45',
    messagingSenderId: '117330271520',
    projectId: 'flutter-aplication-teste',
    storageBucket: 'flutter-aplication-teste.appspot.com',
    iosClientId: '117330271520-a89av0j4oh8um6qs16fo62ijuipuc05n.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplicationTeste',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBc-lLpYFgpPJygwD8gHlXg5tr5GqEDrxU',
    appId: '1:117330271520:ios:759ba3e797afaea8f98b45',
    messagingSenderId: '117330271520',
    projectId: 'flutter-aplication-teste',
    storageBucket: 'flutter-aplication-teste.appspot.com',
    iosClientId: '117330271520-a89av0j4oh8um6qs16fo62ijuipuc05n.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplicationTeste',
  );
}
