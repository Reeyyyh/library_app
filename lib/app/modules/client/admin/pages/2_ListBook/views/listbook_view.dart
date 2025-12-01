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

  final controller = Get.put(ListBookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Daftar Buku",
        showBack: false,
      ),
      body: StreamBuilder<List<BookModel>>(
        stream: controller.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const BookEmpty();
          }

          final books = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: books.length,
            itemBuilder: (_, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () => Get.to(() => UpdatebookView(book)),
                onDelete: () => _confirmDelete(book),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomAppTheme.primaryColor,
        onPressed: () => Get.to(() => CreatebookView()),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

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
              "Hapus Buku?",
              style: CustomAppTheme.heading2.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text("Apakah yakin ingin menghapus \"${book.judul}\"?"),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: const Text("Batal",
                        style: TextStyle(color: Colors.red)),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomAppTheme.primaryColor,
                    ),
                    child: const Text(
                      "Hapus",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      await controller.deleteBook(book.id);
                      Get.back();
                      Get.snackbar(
                        "Berhasil",
                        "Buku dihapus",
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
// merge