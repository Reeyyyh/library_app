import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/controllers/login_controller.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/auth/views/register_view.dart';
import 'package:library_app/app/modules/client/admin/botnav/views/admin_botnav_view.dart';
import 'package:library_app/app/modules/client/users/botnav/views/user_botnav_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // Controller sederhana dulu
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // BAGIAN KONTEN
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  24,
                  72,
                  24,
                  24 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: CustomAppTheme.bodyText.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Masuk untuk mengakses koleksi buku perpustakaan dengan mudah.',
                      style: CustomAppTheme.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 56),
                    Obx(() => CustomInput(
                          labelText: 'Email',
                          hintText: 'Masukan Email',
                          controller: emailC,
                          errorMessage: loginController.emailError.value,
                          showSuccessBorder: loginController.emailSuccess.value,
                        )),
                    const SizedBox(height: 16),
                    Obx(() => CustomInput(
                          labelText: 'Password',
                          hintText: 'Masukan Password',
                          controller: passC,
                          isPassword: true,
                          errorMessage: loginController.passwordError.value,
                          showSuccessBorder:
                              loginController.passwordSuccess.value,
                        )),
                    const SizedBox(height: 26),
                    CustomButton(
                      text: "Masuk",
                      onPressed: () async {
                        bool ok =
                            loginController.validate(emailC.text, passC.text);

                        if (!ok) return;

                        final auth = Get.find<AuthService>();
                        String? result = await auth.login(
                            emailC.text.trim(), passC.text.trim());

                        if (result != null) {
                          Get.snackbar(
                            "Gagal",
                            result,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        
                        String role = auth.userModel.value?.role ?? 'user';

                        if (role == 'admin') {
                          Get.offAll(() => AdminBotNavView());
                        } else {
                          Get.offAll(() => UserBotNavView());
                        }
                      },
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun?',
                          style: CustomAppTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offAll(() => RegisterView()),
                          child: Text(
                            ' Daftar',
                            style: CustomAppTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: CustomAppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // FOOTER TETAP DI BAWAH
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
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
