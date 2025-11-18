import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  final authC = Get.find<AuthController>();

  void onSubmit() {
    if (emailController.text.isEmpty) {
      emailError.value = "Email tidak boleh kosong";
      return;
    }
    emailError.value = "";

    if (passwordController.text.isEmpty) {
      passwordError.value = "Password tidak boleh kosong";
      return;
    }
    passwordError.value = "";

    authC.login(
      emailController.text.trim(),
      passwordController.text,
    );
  }
}