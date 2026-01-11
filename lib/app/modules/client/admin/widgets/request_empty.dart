import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class RequestEmpty extends StatelessWidget {
  const RequestEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 52,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 14),
              Text(
                "Belum Ada Pengajuan",
                style: CustomAppTheme.bodyText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Permintaan peminjaman buku dari pengguna akan muncul di sini.",
                textAlign: TextAlign.center,
                style: CustomAppTheme.caption.copyWith(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
