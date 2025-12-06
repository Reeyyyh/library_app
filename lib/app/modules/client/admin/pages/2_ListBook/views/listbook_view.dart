import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/controllers/listbook_controller.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/views/createbook_view.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/views/updatebook_view.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/client/admin/widgets/book_card.dart';
import 'package:library_app/app/modules/client/admin/widgets/book_empty.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class ListBook extends StatelessWidget {
  ListBook({super.key});

  final controller = Get.put(ListBookController()); // Inisialisasi controller ListBook

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Daftar Buku", // Judul halaman
        showBack: false, // Tidak menampilkan tombol back
      ),

      // Stream untuk mendapatkan daftar buku secara realtime
      body: StreamBuilder<List<BookModel>>(
        stream: controller.getBooks(), // Mendengarkan data dari Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading saat fetch data
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const BookEmpty(); // Tampilan kosong jika tidak ada buku
          }

          final books = snapshot.data!; // Data buku dari snapshot

          // List tampilan data buku
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: books.length,
            itemBuilder: (_, index) {
              final book = books[index]; // Item buku
              return BookCard(
                book: book, // Menampilkan data buku ke card
                onTap: () => Get.to(() => UpdatebookView(book)), // Navigasi ke update buku
                onDelete: () => _confirmDelete(book), // Trigger konfirmasi hapus
              );
            },
          );
        },
      ),

      // Tombol tambah buku
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomAppTheme.primaryColor,
        onPressed: () => Get.to(() => CreatebookView()), // Ke halaman tambah buku
        child: const Icon(
          Icons.add, // Ikon +
          color: Colors.white,
        ),
      ),
    );
  }

  // Dialog konfirmasi hapus buku
  void _confirmDelete(BookModel book) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hapus Buku?", // Judul konfirmasi
              style: CustomAppTheme.heading2.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text("Apakah yakin ingin menghapus \"${book.judul}\"?"), // Info nama buku
            const SizedBox(height: 20),

            // Tombol aksi hapus dan batal
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: const Text("Batal",
                        style: TextStyle(color: Colors.red)),
                    onPressed: () => Get.back(), // Menutup modal
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomAppTheme.primaryColor,
                    ),
                    child: const Text(
                      "Hapus", // Tombol hapus
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      await controller.deleteBook(book.id); // Menghapus buku berdasarkan ID
                      Get.back(); // Tutup modal
                      Get.snackbar(
                        "Berhasil",
                        "Buku dihapus", // Notifikasi berhasil menghapus
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
