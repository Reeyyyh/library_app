import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
// widget yang menampilkan pesan ketika tidak ada riwayat peminjaman buku
class HistoryEmpty extends StatelessWidget {
  const HistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON EMPTY
            Icon(
              Icons.history_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),

            // TITLE
            Text(
              "Belum Ada Riwayat Peminjaman",
              textAlign: TextAlign.center,
              style: CustomAppTheme.heading3.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            // DESCRIPTION
            Text(
              "Anda belum pernah melakukan peminjaman buku. "
              "Silakan lihat katalog dan ajukan peminjaman.",
              textAlign: TextAlign.center,
              style: CustomAppTheme.bodyText.copyWith(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
