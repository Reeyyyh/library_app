import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/client/users/pages/3_History/views/history_detail_view.dart';

class HistoryCard extends StatelessWidget {
  final LoanRequest data;

  const HistoryCard({
    super.key,
    required this.data,
  });

  // ==== Helper format tanggal (dd/MM/yyyy -> dd MMM yyyy) ====
  String formatTanggal(String input) {
    try {
      final parts = input.split('/');
      final day = parts[0];
      final month = parts[1];
      final year = parts[2];

      const monthNames = {
        '01': 'Jan',
        '02': 'Feb',
        '03': 'Mar',
        '04': 'Apr',
        '05': 'Mei',
        '06': 'Jun',
        '07': 'Jul',
        '08': 'Agu',
        '09': 'Sep',
        '10': 'Okt',
        '11': 'Nov',
        '12': 'Des',
      };

      return "$day ${monthNames[month]} $year";
    } catch (_) {
      return input;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HistoryDetailView(loan: data));
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ==== Thumbnail Buku ====
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  data.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade300,
                      child:
                          const Icon(Icons.book, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // ==== Detail ====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Buku
                    Text(
                      data.judulBuku,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Tanggal pinjam - kembali (formatted)
                    Text(
                      "${formatTanggal(data.tanggalPinjam)} - ${formatTanggal(data.tanggalKembali)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
