import 'package:flutter/material.dart';
import 'package:library_app/app/models/admin/book_model.dart';
import 'package:library_app/app/modules/client/users/widgets/borrow_confirm_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_button.dart';

import 'package:library_app/app/widgets/custom_date_input.dart';

class BorrowConfirmView extends StatefulWidget {
  final BookModel book;
  const BorrowConfirmView({super.key, required this.book});

  @override
  State<BorrowConfirmView> createState() => _BorrowConfirmViewState();
}

class _BorrowConfirmViewState extends State<BorrowConfirmView> {
  DateTime borrowDate = DateTime.now();
  int duration = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomAppTheme.backgroundColor,
        title: const Text("Sewa Buku"),
        centerTitle: false,
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
            BorrowConfirmCard(book: widget.book),
            const SizedBox(height: 20),

            // Informasi Pinjam
            Text(
              "Informasi Pinjam",
              style: CustomAppTheme.heading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity, // full width
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal Pinjam",
                    style: CustomAppTheme.subheading.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CustomDateInput(
                    label: "Pilih tanggal",
                    selectedDate: borrowDate,
                    onDateChanged: (date) {
                      setState(() {
                        borrowDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Tanggal Kembali",
                    style: CustomAppTheme.subheading.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CustomDateInput(
                    label: "Pilih tanggal",
                    selectedDate: borrowDate.add(Duration(days: duration)),
                    onDateChanged: (date) {
                      setState(() {
                        duration = date.difference(borrowDate).inDays;
                      });
                    },
                  ),
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

            Container(
              width: double.infinity, // full width
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nama Peminjam:", style: CustomAppTheme.bodyText),
                      Text("John Doe", style: CustomAppTheme.bodyText),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal Pinjam:", style: CustomAppTheme.bodyText),
                      Text("${borrowDate.toLocal()}".split(' ')[0],
                          style: CustomAppTheme.bodyText),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal Kembali:", style: CustomAppTheme.bodyText),
                      Text(
                          "${borrowDate.add(Duration(days: duration)).toLocal()}"
                              .split(' ')[0],
                          style: CustomAppTheme.bodyText),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Durasi:", style: CustomAppTheme.bodyText),
                      Text("$duration hari", style: CustomAppTheme.bodyText),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Judul Buku:", style: CustomAppTheme.bodyText),
                      Text(widget.book.judul, style: CustomAppTheme.bodyText),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kategori:", style: CustomAppTheme.bodyText),
                      Text(widget.book.kategori,
                          style: CustomAppTheme.bodyText),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Submit Sewa",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
