import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

// ignore: non_constant_identifier_names
Widget borrow_status_cancelled() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text(
              "Permintaan Dibatalkan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          "Permintaan peminjaman ini telah dibatalkan oleh Anda.",
          style: CustomAppTheme.mutedText.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.red.shade800,
          ),
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget borrow_status_rejected() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: Colors.orange.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              "Permintaan Ditolak",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Permintaan peminjaman ini ditolak admin.",
          style: CustomAppTheme.mutedText.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange.shade800,
          ),
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget borrow_status_returned() {
  return Container(
    width: double.infinity, // FULL WIDTH
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: CustomAppTheme.primaryColor.withOpacity(0.12), // soft background
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: CustomAppTheme.primaryColor.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: CustomAppTheme.primaryColor,
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "Buku sudah dikembalikan.",
            style: CustomAppTheme.mutedText.copyWith(
              fontWeight: FontWeight.w700,
              color: CustomAppTheme.primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
