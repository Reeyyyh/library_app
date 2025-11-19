import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';
import 'package:library_app/app/modules/config/theme.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // supaya footer tidak ikut naik
      body: SafeArea(
        child: Stack(
          children: [
            // Konten scrollable
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 48,
                  bottom: 100 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Sekarang',
                      style: AppTheme.bodyText.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Daftar untuk mulai meminjam dan\nmengelola koleksi buku perpustakaan',
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomInput(
                      labelText: 'Nama Lengkap :',
                      hintText: 'Masukkan Nama Lengkap',
                      controller: nameC,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      labelText: 'Email :',
                      hintText: 'Masukkan Email',
                      controller: emailC,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      labelText: 'Password :',
                      hintText: 'Masukan Password',
                      controller: passwordC,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      labelText: 'Konfirmasi Password :',
                      hintText: 'Masukan Ulang Password',
                      controller: confirmPasswordC,
                      isPassword: true,
                    ),
                    const SizedBox(height: 26),
                    CustomButton(
                      text: "Daftar",
                      onPressed: () {
                        Get.offAllNamed('/home');
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
                          onTap: () {
                            Get.offAll(() => LoginView());
                          },
                          child: Text(
                            ' Masuk',
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
