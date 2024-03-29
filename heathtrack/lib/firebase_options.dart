//file để kết nối với firebase
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDDUJMRH17DB8QkOdSFbSYG-_DFrb4Co3Y',
    appId: '1:276426229088:web:98b12d72329500e0e60a05',
    messagingSenderId: '276426229088',
    projectId: 'health-care-project-f7c4d',
    authDomain: 'health-care-project-f7c4d.firebaseapp.com',
    storageBucket: 'health-care-project-f7c4d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMPdygSAnlm4GiDrJ5-lLSGArjZx5GUCU',
    appId: '1:276426229088:android:e89fb73808e936e9e60a05',
    messagingSenderId: '276426229088',
    projectId: 'health-care-project-f7c4d',
    storageBucket: 'health-care-project-f7c4d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0q-AK2EKk5A_Uob5BsUGJHKHy6csvub8',
    appId: '1:276426229088:ios:dc95ff03a3c8b64de60a05',
    messagingSenderId: '276426229088',
    projectId: 'health-care-project-f7c4d',
    storageBucket: 'health-care-project-f7c4d.appspot.com',
    iosBundleId: 'com.example.heathtrack',
  );
}
