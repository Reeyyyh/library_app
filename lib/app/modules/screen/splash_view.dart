import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:library_app/app/modules/config/theme.dart';
import 'package:library_app/app/modules/screen/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // ======== BAGIAN TENGAH: LOGO + LOADING ========
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 125,
                      width: 125,
                      child: Lottie.asset(
                        'assets/lottie/Loading.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ======== TEXT DI PALING BAWAH ========
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "SMP MA'ARIF KOTA BATU",
                style: AppTheme.heading3.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
