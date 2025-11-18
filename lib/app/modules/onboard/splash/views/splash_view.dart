import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        final authC = Get.find<AuthController>();
        if (authC.isLoggedIn.value) {
          // Sudah login → pakai route supaya binding HomeController jalan
          Get.offAllNamed('/home');
        } else {
          Get.offAllNamed('/welcome');
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              )),
            ),
            Text(
              'SMP MA’ARIF KOTA BATU',
              style: AppTheme.heading3.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
          ],
        )
            .animate()
            .move(
              begin: Offset(0, 1),
              end: Offset(0, 0),
            )
            .fadeIn(
              duration: 500.ms,
            ),
      ),
    );
  }
}
