import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            72,
            24,
            10,
          ),
          child: ListView(
            children: [
              Text(
                'Selamat Datang',
                style: AppTheme.bodyText.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Masuk untuk mengakses koleksi buku perpustakaan dengan mudah.',
                style: AppTheme.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 56),
              Obx(
                () => CustomInput(
                  labelText: 'Email',
                  controller: controller.emailController,
                  errorMessage: controller.emailError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomInput(
                  labelText: 'Password',
                  isPassword: true,
                  controller: controller.passwordController,
                  errorMessage: controller.passwordError.value,
                ),
              ),
              const SizedBox(height: 26),
              Obx(
                () {
                  final auth = controller.authC;

                  return CustomButton(
                    text: "Login",
                    onPressed:
                        auth.isLoading.value ? null : controller.onSubmit,
                    isLoading: auth.isLoading.value,
                  );
                },
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Belum punya akun?',
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Daftar',
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
