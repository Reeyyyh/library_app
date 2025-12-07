import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class LoanRequestCard extends StatelessWidget {
  final LoanRequestWithDetail data;
  final VoidCallback? onTap;
  final dateFormatter = DateFormat('dd MMM yyyy');

  LoanRequestCard({super.key, required this.data, this.onTap});

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
              Text('Peminjam:', style: CustomAppTheme.heading4),
              Text(data.user.name, style: CustomAppTheme.bodyText),
              Text(data.user.email, style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(),
              Text('Buku:', style: CustomAppTheme.heading4),
              Text(data.book.book.judul, style: CustomAppTheme.bodyText),
              Text(data.book.category.name, style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(),
              Text('Detail Pinjaman:', style: CustomAppTheme.heading4),
              Text(
                  'Pinjam: ${dateFormatter.format(data.request.tanggalPinjam)}',
                  style: CustomAppTheme.caption),
              Text(
                  'Kembali: ${dateFormatter.format(data.request.tanggalKembali)}',
                  style: CustomAppTheme.caption),
              const SizedBox(height: 8),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: data.request.requestStatus == 'pending'
                          ? Colors.orange.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data.request.requestStatus,
                      style: CustomAppTheme.bodyText.copyWith(
                        color: data.request.requestStatus == 'pending'
                            ? Colors.orange
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
