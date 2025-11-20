import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/controllers/register_controller.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // ================================
            // BAGIAN YANG BISA DI SCROLL
            // ================================
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 48,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      'Daftar Sekarang',
                      style: CustomAppTheme.bodyText.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Daftar untuk mulai meminjam dan\nmengelola koleksi buku perpustakaan',
                      style: CustomAppTheme.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ==========================
                    // NAME
                    // ==========================
                    Obx(() => CustomInput(
                          labelText: 'Nama Lengkap :',
                          hintText: 'Masukkan Nama Lengkap',
                          controller: nameC,
                          errorMessage: registerController.nameError.value,
                          showSuccessBorder:
                              registerController.nameSuccess.value,
                        )),

                    const SizedBox(height: 16),

                    // ==========================
                    // EMAIL
                    // ==========================
                    Obx(() => CustomInput(
                          labelText: 'Email :',
                          hintText: 'Masukkan Email',
                          controller: emailC,
                          errorMessage: registerController.emailError.value,
                          showSuccessBorder:
                              registerController.emailSuccess.value,
                        )),

                    const SizedBox(height: 16),

                    // ==========================
                    // PASSWORD
                    // ==========================
                    Obx(() => CustomInput(
                          labelText: 'Password :',
                          hintText: 'Masukkan Password',
                          controller: passwordC,
                          isPassword: true,
                          errorMessage: registerController.passwordError.value,
                          showSuccessBorder:
                              registerController.passwordSuccess.value,
                        )),

                    const SizedBox(height: 16),

                    // ==========================
                    // CONFIRM PASSWORD
                    // ==========================
                    Obx(() => CustomInput(
                          labelText: 'Konfirmasi Password :',
                          hintText: 'Masukkan Ulang Password',
                          controller: confirmPasswordC,
                          isPassword: true,
                          errorMessage:
                              registerController.confirmPasswordError.value,
                          showSuccessBorder:
                              registerController.confirmPasswordSuccess.value,
                        )),

                    const SizedBox(height: 26),

                    // REGISTER BUTTON
                    CustomButton(
                      text: "Daftar",
                      onPressed: () async {
                        final isValid = registerController.validate(
                          name: nameC.text,
                          email: emailC.text,
                          password: passwordC.text,
                          confirmPassword: confirmPasswordC.text,
                        );

                        if (!isValid) return;

                        await registerController.doRegister(
                          name: nameC.text.trim(),
                          email: emailC.text.trim(),
                          password: passwordC.text.trim(),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    // SUDAH PUNYA AKUN?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun?',
                          style: CustomAppTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => LoginView());
                          },
                          child: Text(
                            ' Masuk',
                            style: CustomAppTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: CustomAppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // ================================
            // FOOTER TETAP DI BAWAH
            // ================================
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SMP MA'ARIF KOTA BATU",
                style: CustomAppTheme.heading3.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
