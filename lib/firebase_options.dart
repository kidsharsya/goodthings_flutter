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
    apiKey: 'AIzaSyBJqqV9szSs-q-dUAunjaaPvR2olnuxZoA',
    appId: '1:307721831422:web:de8e91473bce2d0d15f6af',
    messagingSenderId: '307721831422',
    projectId: 'project-tekmob',
    authDomain: 'project-tekmob.firebaseapp.com',
    storageBucket: 'project-tekmob.appspot.com',
    measurementId: 'G-48QPF6HPCG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5DdQQRDRCDLSbs5k7tfbkHb95h_fXn7A',
    appId: '1:307721831422:android:876da12713a7f6d115f6af',
    messagingSenderId: '307721831422',
    projectId: 'project-tekmob',
    storageBucket: 'project-tekmob.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDa4jT-ftkEi32DKgsP_oJ3AQMJQ5hPLtc',
    appId: '1:307721831422:ios:370dae07e91efd4f15f6af',
    messagingSenderId: '307721831422',
    projectId: 'project-tekmob',
    storageBucket: 'project-tekmob.appspot.com',
    iosBundleId: 'com.example.goodthingsAppProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDa4jT-ftkEi32DKgsP_oJ3AQMJQ5hPLtc',
    appId: '1:307721831422:ios:370dae07e91efd4f15f6af',
    messagingSenderId: '307721831422',
    projectId: 'project-tekmob',
    storageBucket: 'project-tekmob.appspot.com',
    iosBundleId: 'com.example.goodthingsAppProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBJqqV9szSs-q-dUAunjaaPvR2olnuxZoA',
    appId: '1:307721831422:web:ad785e289817c16215f6af',
    messagingSenderId: '307721831422',
    projectId: 'project-tekmob',
    authDomain: 'project-tekmob.firebaseapp.com',
    storageBucket: 'project-tekmob.appspot.com',
    measurementId: 'G-1X9KCH630G',
  );
}