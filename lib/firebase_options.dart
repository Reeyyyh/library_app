// File ini di-generate otomatis oleh FlutterFire CLI
// Jangan diedit secara manual kecuali benar-benar diperlukan
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Kelas yang menyimpan konfigurasi Firebase untuk setiap platform
class DefaultFirebaseOptions {

  // Getter untuk menentukan konfigurasi Firebase
  // berdasarkan platform yang sedang digunakan
  static FirebaseOptions get currentPlatform {
    // Jika aplikasi berjalan di Web
    if (kIsWeb) {
      return web;
    }

    // Switch berdasarkan platform target (Android, iOS, dll)
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      // Platform di bawah ini belum dikonfigurasi
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

      // Fallback jika platform tidak dikenali
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Konfigurasi Firebase untuk platform Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCZki_QLgZeElTTzydsknJjdZ8roGhX6B8',
    appId: '1:609167752988:web:928db92288df5bf30344d9',
    messagingSenderId: '609167752988',
    projectId: 'libapp-1dd5f',
    authDomain: 'libapp-1dd5f.firebaseapp.com',
    storageBucket: 'libapp-1dd5f.firebasestorage.app',
  );

  // Konfigurasi Firebase untuk platform Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBm_oI2LyX5VUTFB4mX8nGTk7Lsv8SkvcE',
    appId: '1:609167752988:android:b218b36b9fc4ccdd0344d9',
    messagingSenderId: '609167752988',
    projectId: 'libapp-1dd5f',
    storageBucket: 'libapp-1dd5f.firebasestorage.app',
  );

  // Konfigurasi Firebase untuk platform iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKrPhbBCQBJo6rwhmF94DP8YoK1srFDys',
    appId: '1:609167752988:ios:f2829147872df4310344d9',
    messagingSenderId: '609167752988',
    projectId: 'libapp-1dd5f',
    storageBucket: 'libapp-1dd5f.firebasestorage.app',
    iosBundleId: 'com.bima.libraryApp',
  );
}
