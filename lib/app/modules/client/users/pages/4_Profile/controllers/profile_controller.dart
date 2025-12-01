import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';

class ProfileController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  // Akses langsung ke userModel
  String? get name => auth.userModel.value?.name;
  String? get email => auth.userModel.value?.email;
  String? get className => auth.userModel.value?.kelas;
  String? get phone => auth.userModel.value?.kontak;
  String? get image => auth.userModel.value?.image;
  String? get role => auth.userModel.value?.role;

  // LOGOUT
  Future<void> logout() async {
    try {
      await auth.logout();

      Get.offAll(() => LoginView());
      Get.snackbar(
        'Success',
        'Berhasil logout',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal logout: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
// merge