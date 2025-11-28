import 'package:flutter/material.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class HistoryDetailCard extends StatelessWidget {
  final LoanRequest loan;
  final VoidCallback? onDetailTap;

  const HistoryDetailCard({
    super.key,
    required this.loan,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, // penting!
            children: [
              // GAMBAR (tinggi otomatis mengikuti tinggi Row)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 80,
                  child: Image.network(
                    loan.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.book,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // DETAIL
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loan.judulBuku,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _info("Tahun Terbit", loan.tahun),
                    _info("Penulis", loan.penulis),
                    _info("Penerbit", loan.penerbit),
                    _info("Kategori", loan.category),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: onDetailTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          color: CustomAppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Lihat Detail",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Text(
        "$label: $value",
        style: CustomAppTheme.mutedText.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
