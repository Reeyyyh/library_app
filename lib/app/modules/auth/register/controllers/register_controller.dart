import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxString nameError = ''.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  final authC = Get.find<AuthController>();

  Future<void> onSubmit() async {
    if (nameController.text.isEmpty) {
      nameError.value = "Nama tidak boleh kosong";
      return;
    }
    nameError.value = "";

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

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = "Password tidak sama";
      return;
    }
    confirmPasswordError.value = "";

    await authC.register(
      emailController.text.trim(),
      passwordController.text,
      nameController.text.trim(),
    );
  }
}
