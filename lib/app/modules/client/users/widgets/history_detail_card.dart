import 'package:flutter/material.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class HistoryDetailCard extends StatelessWidget {
  final LoanRequestWithDetail loan;
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
                    loan.book.book.image,
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
                      loan.book.book.judul,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _info("Tahun Terbit", loan.book.book.tahun),
                    _info("Penulis", loan.book.book.penulis),
                    _info("Penerbit", loan.book.book.penerbit),
                    _info("Kategori", loan.book.category.name),
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
// merge