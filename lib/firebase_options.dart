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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIesjrZ5uik68e_0vfeRUdG41XA_W-DOk',
    appId: '1:225492704105:android:4d0f9ddbff4725cde43bf8',
    messagingSenderId: '225492704105',
    projectId: 'chatapp-66cbd',
    databaseURL: 'https://chatapp-66cbd-default-rtdb.firebaseio.com',
    storageBucket: 'chatapp-66cbd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw8IUcFEuBnTFnPica0QyfT2IG0baieeM',
    appId: '1:225492704105:ios:8480917b96ad1c8ae43bf8',
    messagingSenderId: '225492704105',
    projectId: 'chatapp-66cbd',
    databaseURL: 'https://chatapp-66cbd-default-rtdb.firebaseio.com',
    storageBucket: 'chatapp-66cbd.appspot.com',
    androidClientId: '225492704105-iquho3cedf966k5belho1eta6erairdk.apps.googleusercontent.com',
    iosClientId: '225492704105-0u2vd7ved158apgt2m64nq52blfunbss.apps.googleusercontent.com',
    iosBundleId: 'com.mrthnby.chatApp',
  );
}
