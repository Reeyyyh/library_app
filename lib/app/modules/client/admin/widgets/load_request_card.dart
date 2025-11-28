import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/models/loan_request_model.dart'; // import model

class LoanRequestCard extends StatelessWidget {
  final LoanRequest data; // pakai model
  final VoidCallback? onTap;

  const LoanRequestCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Peminjam
              Text('Peminjam:', style: CustomAppTheme.heading4),
              Text(data.nama, style: CustomAppTheme.bodyText),
              Text(data.email, style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.grey),

              // Buku
              Text('Buku:', style: CustomAppTheme.heading4),
              Text(data.judulBuku, style: CustomAppTheme.bodyText),
              Text(data.category, style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.grey),

              // Detail pinjam
              Text('Detail Pinjaman:', style: CustomAppTheme.heading4),
              Text('Pinjam: ${data.tanggalPinjam}', style: CustomAppTheme.caption),
              Text('Kembali: ${data.tanggalKembali}', style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.grey),

              // Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: data.requestStatus == 'Pending'
                          ? Colors.orange.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data.requestStatus,
                      style: CustomAppTheme.bodyText.copyWith(
                        color: data.requestStatus == 'Pending' ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: CustomAppTheme.primaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
