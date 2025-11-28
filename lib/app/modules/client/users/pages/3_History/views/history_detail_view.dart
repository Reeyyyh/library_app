import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/client/users/pages/3_History/controllers/history_detail_controller.dart';
import 'package:library_app/app/modules/client/users/widgets/borrow_status_card.dart';
import 'package:library_app/app/modules/client/users/widgets/history_detail_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

class HistoryDetailView extends StatelessWidget {
  final LoanRequest loan;
  final HistoryDetailController controller = Get.put(HistoryDetailController());

  HistoryDetailView({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd/MM/yyyy");

    formatter.parse(loan.tanggalPinjam);
    final DateTime tanggalKembali = formatter.parse(loan.tanggalKembali);
    final DateTime now = DateTime.now();

    final int durasiPinjam = tanggalKembali.difference(now).inDays;

    // SET DATA KE CONTROLLER (Reactive)
    controller.setLoan(loan);

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'Detail Peminjaman',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================
            // INFORMASI BUKU
            // ========================================
            const Text(
              "Informasi Buku",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            HistoryDetailCard(
              loan: loan,
              onDetailTap: () {},
            ),

            const SizedBox(height: 28),

            // ========================================
            // PROFIL PEMINJAM
            // ========================================
            const Text(
              "Profil Peminjam",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _whiteBox(
              children: [
                _infoRow("Nama", loan.nama),
                _infoRow("Email", loan.email),
                _infoRow("Kelas", loan.kelas),
                _infoRow("Kontak", loan.kontak),
              ],
            ),

            const SizedBox(height: 28),

            // ========================================
            // RINCIAN PEMINJAMAN
            // ========================================
            const Text(
              "Rincian Peminjaman",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _whiteBox(
              children: [
                _infoRow("Tanggal Pinjam", loan.tanggalPinjam),
                _infoRow("Batas Pengembalian", loan.tanggalKembali),

                Text(
                  "Durasi: ${durasiPinjam >= 0 ? "$durasiPinjam hari" : "${durasiPinjam.abs()} hari terlambat"}",
                  style: CustomAppTheme.mutedText,
                ),

                const SizedBox(height: 6),

                // STATUS REACTIVE
                Obx(() =>
                    _infoRow("Request Status", controller.loan.value.requestStatus)),
              ],
            ),

            const SizedBox(height: 40),

            // TOMBOL REACTIVE
            Obx(() => _buildActionButton()),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // HELPERS
  // ========================================================================

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: CustomAppTheme.mutedText),
          Expanded(
            child: Text(value, style: CustomAppTheme.mutedText),
          ),
        ],
      ),
    );
  }

  Widget _whiteBox({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildActionButton() {
    final String status = controller.loan.value.requestStatus;

    if (status == "pending") {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.cancelRequest(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            "Batalkan Permintaan",
            style: CustomAppTheme.mutedText.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    if (status == "accepted") {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.returnBook(),
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomAppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            "Kembalikan Sekarang",
            style: CustomAppTheme.mutedText.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    if (status == "rejected") {
      return borrow_status_rejected();
    }

    if (status == "returned") {
      return borrow_status_returned();
    }

    if (status == "cancelled") {
      return borrow_status_cancelled();
    }

    return const SizedBox.shrink();
  }
}
