import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/borrow_confirm_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';

class BookDetailView extends StatelessWidget {
  final BookWithCategoryModel bookData;

  const BookDetailView({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final statusLabel =
        bookData.book.status == BookStatus.tersedia ? 'Tersedia' : 'Tidak Tersedia';

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: CustomAppBar(title: 'Detail Buku'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          _buildBookImage(bookData.book.image),
          const SizedBox(height: 22),
          Text(
            bookData.book.judul,
            style: CustomAppTheme.heading1.copyWith(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 12),
          _buildInformationTitle('Informasi'),
          const SizedBox(height: 8),
          _buildBookInfoTable(bookData, statusLabel),
          const SizedBox(height: 8),
          _buildInformationTitle('Deskripsi Buku'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              bookData.book.deskripsi,
              style: CustomAppTheme.bodyText,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: bookData.book.status == BookStatus.tersedia
                ? 'Sewa Sekarang'
                : 'Tidak Tersedia',
            onPressed: bookData.book.status == BookStatus.tersedia
                ? () {
                    Get.to(() => BorrowConfirmView(bookData: bookData));
                  }
                : null, // null = otomatis disabled
          ),
        ],
      ),
    );
  }

  Widget _buildBookImage(String? imageUrl) {
    return Hero(
      tag: imageUrl ?? 'placeholder',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageUrl == null || imageUrl.isEmpty
            ? Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.book_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildInformationTitle(String title) {
    return Text(
      title,
      style: CustomAppTheme.heading2.copyWith(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }

  Widget _buildBookInfoTable(BookWithCategoryModel book, String statusLabel) {
    final List<TableRow> rows = [
      _buildTableRow('Penulis', book.book.judul, 0),
      _buildTableRow('Penerbit', book.book.penerbit, 1),
      _buildTableRow('Tahun Terbit', book.book.tahun, 2),
      _buildTableRow('Stok', book.book.stok.toString(), 3),
      _buildTableRow('Status', statusLabel, 4),
      _buildTableRow('Kategori', book.category.name, 5),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(4),
          },
          children: rows,
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, int index) {
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : const Color(0xffF6F6F6),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
// merge