import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/img/icon_welcome.jpg',
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      Text(
                        'Selamat Datang',
                        style: CustomAppTheme.heading1.copyWith(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Temukan koleksi buku sesuai dengan kebutuhan belajarmu dan pinjam dengan mudah melalui aplikasi ini.',
                        style: CustomAppTheme.caption.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAll(() => LoginView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomAppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Mulai Sekarang!',
                              style: CustomAppTheme.bodyText.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "SMP MA'ARIF KOTA BATU",
              style: CustomAppTheme.heading3.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// merge