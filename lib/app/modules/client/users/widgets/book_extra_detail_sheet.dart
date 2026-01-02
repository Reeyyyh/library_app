import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';

class BookExtraDetailSheet extends StatelessWidget {
  final LoanRequestWithDetail loan;

  const BookExtraDetailSheet({super.key, required this.loan});

  // ===== HELPER UNTUK NULL HANDLING =====
  String safeText(dynamic value) {
    if (value == null) return "-";
    if (value is String && value.trim().isEmpty) return "-";
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // drag indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const Text(
            "Rincian",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // ===== BOX DETAIL =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _info("ISBN", safeText(loan.book.book.isbn)),
                _info("Jumlah Halaman",
                    safeText(loan.book.book.jumlahHalaman)),
                _info("Bahasa", safeText(loan.book.book.bahasa)),
                _info("Lokasi Rak", safeText(loan.book.book.lokasiRak)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== TOMBOL TUTUP =====
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Tutup",
                  textAlign: TextAlign.center,
                  style: CustomAppTheme.mutedText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        "$label: $value",
        style: CustomAppTheme.mutedText.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
