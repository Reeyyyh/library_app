import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:library_app/app/modules/client/users/botnav/views/user_botnav_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class SuccessBorrowView extends StatelessWidget {
  final String borrowCode;

  const SuccessBorrowView({super.key, required this.borrowCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --------------------------
            // BAGIAN TENGAH (Expanded)
            // --------------------------
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ICON SUKSES
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 100,
                    ),
                    const SizedBox(height: 20),

                    // JUDUL
                    const Text(
                      "Sukses Melakukan Peminjaman",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DESKRIPSI
                    const Text(
                      "Kode sewa ini adalah bukti pengajuan peminjaman Anda. "
                      "Berikan kode ini kepada admin perpustakaan untuk proses "
                      "verifikasi dan pengambilan buku. Pastikan Anda menyimpan "
                      "kode ini dengan baik.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // CARD KODE SEWA
                    // CARD KODE SEWA
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kode Sewa :",
                            style: CustomAppTheme.mutedText
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // KODE SEWA
                              Text(
                                borrowCode,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // ICON COPY
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: borrowCode));
                                  Get.snackbar(
                                    "Disalin",
                                    "Kode sewa berhasil disalin",
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                },
                                child: const Icon(
                                  Icons.copy,
                                  size: 26,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------
            // TOMBOL DI BAGIAN PALING BAWAH
            // ------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomAppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => UserBotNavView());
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: CustomAppTheme.heading3.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// merge