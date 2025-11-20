import 'dart:async';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/client/users/botnav/views/user_botnav_view.dart';
import 'package:library_app/app/modules/screen/welcome_view.dart';
import 'package:library_app/app/modules/client/admin/botnav/views/admin_botnav_view.dart';

class SplashController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  @override
  void onReady() {
    super.onReady();

    // Tunggu animasi Splash 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      _checkUserLogin();
    });
  }

  void _checkUserLogin() {
    final user = auth.firebaseUser.value;

    // Jika user belum login
    if (user == null) {
      Get.offAll(() => WelcomeView());
      return;
    }

    // Jika login → cek data Firestore
    Future.delayed(Duration(milliseconds: 300), () {
      final data = auth.userData;

      if (data.isEmpty) {
        // Jika tidak ditemukan datanya → anggap logout paksa
        auth.logout();
        Get.offAll(() => WelcomeView());
        return;
      }

      final bool isActive = data['is_active'] ?? true;
      final String role = data['role'] ?? 'user';

      // Jika akun dinonaktifkan admin
      if (!isActive) {
        auth.logout();
        Get.offAll(() => WelcomeView());
        return;
      }

      // Role routing
      if (role == 'admin') {
        Get.offAll(() => AdminBotNavView());
      } else {
        Get.offAll(() => UserBotNavView());
      }
    });
  }
}
