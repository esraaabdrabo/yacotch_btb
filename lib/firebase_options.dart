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
    apiKey: 'AIzaSyDmQLQVC3w1RJho1rynDZwEkYzgKIVv42o',
    appId: '1:986744272624:web:795ca91a4f38e58f5b3435',
    messagingSenderId: '986744272624',
    projectId: 'yacotch-fca1b',
    authDomain: 'yacotch-fca1b.firebaseapp.com',
    storageBucket: 'yacotch-fca1b.appspot.com',
    measurementId: 'G-T536S32PSY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2s3AZYiC2TLTz3tXM2xnd0dTIujLn0FA',
    appId: '1:986744272624:android:f781a35a18cdeefc5b3435',
    messagingSenderId: '986744272624',
    projectId: 'yacotch-fca1b',
    storageBucket: 'yacotch-fca1b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy2qf0pwcxQ8a6F2yXAe67t7jWuaj2TgE',
    appId: '1:986744272624:ios:f0bd4bfa24eee0915b3435',
    messagingSenderId: '986744272624',
    projectId: 'yacotch-fca1b',
    storageBucket: 'yacotch-fca1b.appspot.com',
    androidClientId: '986744272624-0jepnenfrdcivind5tvf1gg9gl4l8ogl.apps.googleusercontent.com',
    iosClientId: '986744272624-jm8vpgr1cj326g90b6chpqchla7neski.apps.googleusercontent.com',
    iosBundleId: 'com.yacotch.partner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy2qf0pwcxQ8a6F2yXAe67t7jWuaj2TgE',
    appId: '1:986744272624:ios:38629897ab3ca45f5b3435',
    messagingSenderId: '986744272624',
    projectId: 'yacotch-fca1b',
    storageBucket: 'yacotch-fca1b.appspot.com',
    androidClientId: '986744272624-0jepnenfrdcivind5tvf1gg9gl4l8ogl.apps.googleusercontent.com',
    iosBundleId: 'com.yacotch.traineeRestaurantapp',
  );
}
