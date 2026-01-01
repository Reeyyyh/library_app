import 'package:flutter/material.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
// widget yang menampilkan kartu konfirmasi peminjaman buku
class BorrowConfirmCard extends StatelessWidget {
  final BookModel book;

  const BorrowConfirmCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.judul,
                  style: CustomAppTheme.heading4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  book.penerbit,
                  style: CustomAppTheme.mutedText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.tahun,
                  style: CustomAppTheme.mutedText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: book.image.isNotEmpty
                ? Image.network(
                    book.image,
                    height: 90,
                    width: 70,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 90,
                    width: 70,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
