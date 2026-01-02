import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/controllers/admin_loan_request_detail_controller.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';

class AdminLoanRequestDetailView extends StatelessWidget {
  final LoanRequestWithDetail loan;

  const AdminLoanRequestDetailView({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminLoanRequestDetailController(loan));

    return Scaffold(
      appBar: AdminAppBar(
        title: "Detail Pengajuan",
        showBack: true,
      ),
      body: Obx(() {
        final data = controller.loan.value!;
        final status = data.request.requestStatus;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionCard(
                      title: "Informasi Peminjam",
                      children: [
                        _infoRow("Nama", data.user.name),
                        _infoRow("Judul Buku", data.book.book.judul),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionCard(
                      title: "Detail Peminjaman",
                      children: [
                        _infoRow(
                          "Tanggal Pinjam",
                          data.request.tanggalPinjam
                              .toString()
                              .substring(0, 10),
                        ),
                        _infoRow(
                          "Tanggal Kembali",
                          data.request.tanggalKembali
                              .toString()
                              .substring(0, 10),
                        ),
                        _statusRow(status),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _borrowCodeBox(data.request.borrowCode),
                  ],
                ),
              ),
            ),
            _actionSection(status, controller),
          ],
        );
      }),
    );
  }

  // ===================== UI COMPONENT =====================

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusRow(String status) {
    Color color;
    String text;

    switch (status) {
      case "accepted":
        color = Colors.blue;
        text = "Dipinjam";
        break;
      case "returned":
        color = Colors.green;
        text = "Dikembalikan";
        break;
      default:
        color = Colors.orange;
        text = "Pending";
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "Status",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Chip(
            label: Text(text),
            backgroundColor: color.withOpacity(0.15),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _borrowCodeBox(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Text(
            "Kode Peminjaman",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionSection(
    String status,
    AdminLoanRequestDetailController controller,
  ) {
    if (status == "returned") return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (status == "pending") ...[
            _actionButton(
              "Terima Permintaan",
              Colors.green,
              controller.acceptRequest,
            ),
            const SizedBox(height: 10),
            _actionButton(
              "Tolak Permintaan",
              Colors.red,
              controller.rejectRequest,
            ),
          ],
          if (status == "accepted")
            _actionButton(
              "Tandai Dikembalikan",
              Colors.blue,
              controller.markReturned,
            ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String text,
    Color color,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white, // ⬅️ WARNA TEKS
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // ⬅️ DOUBLE SAFE
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
