import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 72, 24, 10),
          child: ListView(
            children: [
              Text(
                'Daftar Sekarang',
                style: AppTheme.bodyText.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Daftar untuk mulai meminjam buku.',
                style: AppTheme.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 56),

              // INPUTS
              Obx(() => CustomInput(
                    labelText: 'Name',
                    controller: controller.nameController,
                    errorMessage: controller.nameError.value,
                  )),
              const SizedBox(height: 16),

              Obx(() => CustomInput(
                    labelText: 'Email',
                    controller: controller.emailController,
                    errorMessage: controller.emailError.value,
                  )),
              const SizedBox(height: 16),

              Obx(() => CustomInput(
                    labelText: 'Password',
                    isPassword: true,
                    controller: controller.passwordController,
                    errorMessage: controller.passwordError.value,
                  )),
              const SizedBox(height: 16),

              Obx(() => CustomInput(
                    labelText: 'Confirm Password',
                    isPassword: true,
                    controller: controller.confirmPasswordController,
                    errorMessage: controller.confirmPasswordError.value,
                  )),
              const SizedBox(height: 26),

              // BUTTON "DAFTAR"
              Obx(
                () {
                  final auth = controller.authC;

                  return CustomButton(
                    text: "Daftar",
                    onPressed:
                        auth.isLoading.value ? null : controller.onSubmit,
                    isLoading: auth.isLoading.value,
                  );
                },
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      ' Masuk',
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
