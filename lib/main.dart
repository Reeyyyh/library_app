import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/screen/controllers/splash_controller.dart';
import 'package:library_app/app/modules/screen/splash_view.dart';

// Fungsi utama aplikasi
// Digunakan untuk melakukan inisialisasi awal sebelum aplikasi dijalankan
Future<void> main(List<String> args) async {
  // Memastikan binding Flutter telah siap
  // Wajib dipanggil sebelum inisialisasi Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase untuk aplikasi
  await Firebase.initializeApp();

  // Registrasi AuthService sebagai dependency global
  // permanent: true -> service tetap hidup selama aplikasi berjalan
  Get.put(AuthService(), permanent: true);

  // Menjalankan aplikasi utama
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: "Library_app", // Judul aplikasi
      home: SplashView(), // Halaman awal aplikasi

      // Binding awal untuk controller yang dibutuhkan di splash screen
      initialBinding: BindingsBuilder(
        () {
          Get.put(SplashController());
        },
      ),
    ),
  );
}
