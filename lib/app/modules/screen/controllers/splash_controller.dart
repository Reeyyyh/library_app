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

    Future.delayed(const Duration(seconds: 3), () {
      _checkUserLogin();
    });
  }

  void _checkUserLogin() async {
    final session = auth.session.value;

    if (session == null) {
      Get.offAll(() => WelcomeView());
      return;
    }

    // Tunggu userModel terisi max 3 detik
    await Future.doWhile(() async {
      if (auth.userModel.value != null) return false;
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    });

    final user = auth.userModel.value;

    if (user == null || !user.isActive) {
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
