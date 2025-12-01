import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/success_borrow_view.dart';
import 'package:library_app/app/modules/client/users/widgets/borrow_confirm_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_date_input.dart';
import '../controllers/borrow_confirm_controller.dart';

class BorrowConfirmView extends StatelessWidget {
  final BookModel book;
  BorrowConfirmView({super.key, required this.book});

  final BorrowConfirmController controller = Get.put(BorrowConfirmController());

  @override
  Widget build(BuildContext context) {
    final currentUser = controller.authService.userModel.value;
    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: "Sewa Buku",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Buku
            Text(
              "Informasi Buku",
              style: CustomAppTheme.heading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            BorrowConfirmCard(book: book),
            const SizedBox(height: 20),

            // Informasi Pinjam
            Text(
              "Informasi Pinjam",
              style: CustomAppTheme.heading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal Pinjam",
                    style: CustomAppTheme.subheading.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Obx(() => CustomDateInput(
                        selectedDate: controller.borrowDate.value,
                        onDateChanged: controller.setBorrowDate,
                      )),
                  const SizedBox(height: 12),
                  Text(
                    "Tanggal Kembali",
                    style: CustomAppTheme.subheading.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Obx(() => CustomDateInput(
                        selectedDate: controller.borrowDate.value
                            .add(Duration(days: controller.duration.value)),
                        onDateChanged: controller.setReturnDate,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rincian
            Text(
              "Rincian",
              style: CustomAppTheme.heading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Obx(() => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => _buildRow("Nama :", controller.userName.value)),
                      const SizedBox(height: 6),
                      _buildRow(
                          "Tanggal Pinjam:",
                          DateFormat('dd/MM/yyyy')
                              .format(controller.borrowDate.value)),
                      const SizedBox(height: 6),
                      _buildRow(
                          "Tanggal Kembali:",
                          DateFormat('dd/MM/yyyy').format(controller
                              .borrowDate.value
                              .add(Duration(days: controller.duration.value)))),
                      const SizedBox(height: 6),
                      _buildRow("Durasi:", "${controller.duration.value} hari"),
                      const SizedBox(height: 6),
                      _buildRow("Judul Buku:", book.judul),
                      const SizedBox(height: 6),
                      _buildRow("Kategori:", book.kategori),
                    ],
                  ),
                )),

            const SizedBox(height: 20),

            CustomButton(
              text: "Submit Sewa",
              onPressed: () async {
                if (currentUser!.kelas.isEmpty || currentUser.kontak.isEmpty) {
                  Get.snackbar(
                    "",
                    "",
                    titleText: Text(
                      "Perhatian",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    messageText: Text(
                      "Silakan lengkapi Kelas dan Kontak di profil Anda sebelum meminjam buku.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.orange[800],
                    snackPosition: SnackPosition.TOP,
                  );
                  return;
                }

                final borrowCode = controller.generateBorrowCode();

                final loanRequest = LoanRequest(
                  borrowCode: borrowCode,
                  uid: currentUser.uid,
                  nama: currentUser.name,
                  email: currentUser.email,
                  kelas: currentUser.kelas,
                  kontak: currentUser.kontak,
                  bookId: book.id,
                  image: book.image,
                  judulBuku: book.judul,
                  tahun: book.tahun,
                  category: book.kategori,
                  penulis: book.penulis,
                  penerbit: book.penerbit,
                  tanggalPinjam: DateFormat('dd/MM/yyyy')
                      .format(controller.borrowDate.value),
                  tanggalKembali: DateFormat('dd/MM/yyyy').format(controller
                      .borrowDate.value
                      .add(Duration(days: controller.duration.value))),
                  requestStatus: "pending",
                  isbn: book.isbn,
                  jumlahHalaman: book.jumlahHalaman,
                  bahasa: book.bahasa,
                  lokasiRak: book.lokasiRak,
                );
                await controller.submitBorrow(loanRequest);

                Get.to(() => SuccessBorrowView(borrowCode: borrowCode));
              },
            )
          ],
        ),
      ),
    );
  }

  Row _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: CustomAppTheme.mutedText
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
        Text(value,
            style:
                CustomAppTheme.bodyText.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
// merge