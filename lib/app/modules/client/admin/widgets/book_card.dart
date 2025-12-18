import 'package:flutter/material.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

// Widget card untuk menampilkan informasi satu buku
class BookCard extends StatelessWidget {
  // Data buku yang akan ditampilkan
  final BookModel book;

  // Callback ketika tombol hapus ditekan
  final VoidCallback onDelete;

  // Callback ketika card ditekan (misalnya untuk edit/detail)
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onTap,
  });

  // Widget placeholder jika gambar buku tidak tersedia atau gagal dimuat
  Widget _placeholder() {
    return Container(
      width: 55,
      height: 80,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }

  // Widget penanda status buku (tersedia / tidak tersedia)
  Widget _statusTag(BookStatus status) {
    // Mengecek apakah status buku tersedia
    bool isAvailable = status == BookStatus.tersedia;

    // Warna utama berdasarkan status
    Color solidColor = isAvailable ? Colors.green : Colors.red;

    // Warna latar belakang yang lebih lembut
    Color bgSoftColor = solidColor.withOpacity(0.12);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgSoftColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon indikator status (cek / silang)
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
          // Label status dari enum BookStatus
          Text(
            status.label,
            style: TextStyle(
              color: solidColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil status buku langsung dari model
    final status = book.status;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        // Bagian gambar buku
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: book.image.isNotEmpty
              ? Image.network(
                  book.image,
                  width: 55,
                  height: 80,
                  fit: BoxFit.cover,
                  // Fallback jika gagal load gambar
                  errorBuilder: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),

        // Judul buku
        title: Text(
          book.judul,
          style: CustomAppTheme.heading2.copyWith(fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        // Informasi stok dan status buku
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stok: ${book.stok}",
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 4),
            _statusTag(status),
          ],
        ),

        // Aksi ketika card ditekan
        onTap: onTap,

        // Tombol hapus buku
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
