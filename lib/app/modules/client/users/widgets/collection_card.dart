import 'package:flutter/material.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
// widget yang menampilkan kartu koleksi buku
class CollectionCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback? onTap;

  const CollectionCard({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    int kategoriFlex = book.kategori.length <= 6 ? 1 : 2;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar buku
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      image: book.image.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(book.image),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: book.image.isEmpty
                        ? const Center(child: Icon(Icons.book, size: 50))
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul
                        Text(
                          book.judul,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        
                        
                        Row(
                          children: [
                            // Kategori
                            Expanded(
                              flex: kategoriFlex,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: _tag(book.kategori),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Tahun
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: _tag(book.tahun),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Status
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: _statusTag(book.status),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Deskripsi buku
                        Text(
                          book.deskripsi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Stok di kanan bawah
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: book.status == BookStatus.tersedia
                          ? CustomAppTheme.primaryColor
                          : Color(0xFFAE3433),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${book.stok} ', // angka stok
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: 'Jumlah', // label
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper untuk kategori / tahun
Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(

      color: Colors.green.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      maxLines: 1, // penting, supaya tetap satu baris
      overflow: TextOverflow.ellipsis, // tampilkan ... jika kepotong
      style: TextStyle(
        color: CustomAppTheme.primaryColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Helper untuk status badge
Widget _statusTag(BookStatus status) {
  bool isAvailable = status == BookStatus.tersedia;

  Color solidColor = isAvailable ? CustomAppTheme.primaryColor : Colors.red;
  Color bgSoftColor = solidColor.withOpacity(0.12);

  return FittedBox(
    // tambah ini
    fit: BoxFit.scaleDown,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgSoftColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: solidColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAvailable ? Icons.check : Icons.close,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: solidColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
