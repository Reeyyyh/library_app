import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/views/register_view.dart';
import 'package:library_app/app/modules/client/users/botnav/views/user_botnav_view.dart';
import 'package:library_app/app/modules/config/theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // Controller sederhana dulu
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // jangan resize saat keyboard muncul
      body: SafeArea(
        child: Stack(
          children: [
            // Konten scrollable
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24,
                72,
                24,
                100 +
                    MediaQuery.of(context)
                        .viewInsets
                        .bottom, // tambahkan space saat keyboard muncul
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  CustomInput(
                    labelText: 'Email',
                    hintText: 'Masukan Email',
                    controller: emailC,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    labelText: 'Password',
                    hintText: 'Masukan Password',
                    controller: passC,
                    isPassword: true,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    text: "Masuk",
                    onPressed: () {
                      Get.offAll(() => UserBotNavView());
                    },
                    isLoading: false,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun?',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(() => RegisterView());
                        },
                        child: Text(
                          ' Daftar',
                          style: AppTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer tetap di bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "SMP MA'ARIF KOTA BATU",
                  style: AppTheme.heading3.copyWith(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
