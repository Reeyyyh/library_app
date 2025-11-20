import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';

class RegisterController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  // Error state reactive
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  var nameSuccess = false.obs;
  var emailSuccess = false.obs;
  var passwordSuccess = false.obs;
  var confirmPasswordSuccess = false.obs;

  bool validate({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    bool isValid = true;

    // Reset state
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    nameSuccess.value = false;
    emailSuccess.value = false;
    passwordSuccess.value = false;
    confirmPasswordSuccess.value = false;

    // VALIDASI
    if (name.isEmpty) {
      nameError.value = "Nama tidak boleh kosong";
      isValid = false;
    } else {
      nameSuccess.value = true;
    }

    if (email.isEmpty) {
      emailError.value = "Email wajib diisi";
      isValid = false;
    } else if (!email.contains("@")) {
      emailError.value = "Format email tidak valid";
      isValid = false;
    } else {
      emailSuccess.value = true;
    }

    if (password.isEmpty) {
      passwordError.value = "Password wajib diisi";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Minimal 6 karakter";
      isValid = false;
    } else {
      passwordSuccess.value = true;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Konfirmasi wajib diisi";
      isValid = false;
    } else if (confirmPassword.length < 6) {
      confirmPasswordError.value = "Minimal 6 karakter";
      isValid = false;
    } else if (confirmPassword != password) {
      confirmPasswordError.value = "Konfirmasi tidak sesuai";
      isValid = false;
    } else {
      confirmPasswordSuccess.value = true;
    }

    return isValid;
  }

  // ===========================
  // REGISTER FUNCTION
  // ===========================
  Future<void> doRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    String? result = await auth.register(
      name: name,
      email: email,
      password: password,
    );

    if (result != null) {
      // gagal → tampilkan snackbar
      Get.snackbar(
        "Gagal",
        result,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // sukses
      Get.snackbar(
        "Sukses",
        "Registrasi berhasil, silakan login",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAll(() => LoginView());
    }
  }
}
