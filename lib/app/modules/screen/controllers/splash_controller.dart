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
    final firebase = auth.firebaseUser.value;
    final user = auth.userModel.value;

    if (firebase == null || user == null) {
      Get.offAll(() => WelcomeView());
      return;
    }

    if (!user.isActive) {
      auth.logout();
      Get.offAll(() => WelcomeView());
      return;
    }

    if (user.role == 'admin') {
      Get.offAll(() => AdminBotNavView());
    } else {
      Get.offAll(() => UserBotNavView());
    }
  }
}
