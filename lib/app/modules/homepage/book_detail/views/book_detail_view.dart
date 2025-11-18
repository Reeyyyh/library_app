import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import '../controllers/book_detail_controller.dart';

class BookDetailView extends GetView<BookDetailController> {
  const BookDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Detail Buku'),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            40,
          ),
          children: [
            _buildBookImage(),
            const SizedBox(height: 22),
            Text(
              controller.data['judul'],
              style: AppTheme.heading1.copyWith(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            _buildInformationTitle('Informasi'),
            const SizedBox(height: 8),
            _buildBookInfoTable(),
            const SizedBox(height: 8),
            _buildInformationTitle('Deskripsi'),
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                controller.data['deskripsi'],
                style: AppTheme.bodyText,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: controller.data['isDigital'] == true
                  ? 'Baca Sekarang'
                  : 'Pinjam Buku',
              onPressed: () {
                if (controller.data['isDigital'] == true) {
                  Get.toNamed(
                    '/pdf-reader',
                    arguments: controller.data['digitalBookUrl'],
                  );
                } else {
                  // Get.toNamed(
                  //   '/borrow-book',
                  //   arguments: controller.data,
                  // );
                  Get.snackbar(
                    'Info',
                    'Fitur belum tersedia',
                    backgroundColor: Colors.amber,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookImage() {
    return Hero(
      tag: controller.data['imageUrl'],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: controller.data['imageUrl'],
          width: Get.width,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildInformationTitle(String title) {
    return Text(
      title,
      style: AppTheme.heading2.copyWith(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }

  Widget _buildBookInfoTable() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(4),
          },
          children: [
            _buildTableRow('Penulis', controller.data['penulis'], 0),
            _buildTableRow('Penerbit', controller.data['penerbit'], 1),
            _buildTableRow('Tahun Terbit', controller.data['tahun'], 2),
            if (controller.data['isDigital'] == false)
              _buildTableRow('Stok', controller.data['stok'].toString(), 3),
            _buildTableRow(
              'Status',
              controller.data['status'],
              controller.data['isDigital'] == true ? 3 : 4,
            ),
            _buildTableRow('Kategori', controller.category['name'],
                controller.data['isDigital'] == true ? 4 : 5),
          ].whereType<TableRow>().toList(),
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
