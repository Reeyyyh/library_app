import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/controllers/admin_loan_request_controller.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/views/admin_loan_request_detail_view.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/client/users/widgets/request_empty.dart';

class AdminLoanRequestListView extends StatelessWidget {
  AdminLoanRequestListView({super.key});

  final controller = Get.put(AdminLoanRequestController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AdminAppBar(
          title: "Pengajuan Peminjaman",
          showBack: true,
        ),
        body: Column(
          children: [
            // TAB BAR DIPINDAH KE BODY
            const Material(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: "Pending"),
                  Tab(text: "Dipinjam"),
                  Tab(text: "Dikembalikan"),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return TabBarView(
                  children: [
                    _buildList(controller.pendingRequests, "pending"),
                    _buildList(controller.acceptedRequests, "accepted"),
                    _buildList(controller.returnedRequests, "returned"),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List list, String status) {
    if (list.isEmpty) {
      return const RequestEmpty();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final request = list[index];

        return Card(
          elevation: 1.5,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              request.book.book.judul,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text("Peminjam: ${request.user.name}"),
                const SizedBox(height: 2),
                Text(
                  "Tanggal Pinjam: ${request.request.tanggalPinjam.toString().substring(0, 10)}",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: _statusBadge(status),
            onTap: () async {
              await Get.to(
                () => AdminLoanRequestDetailView(loan: request),
              );

              controller.fetchLoanRequests();
            },
          ),
        );
      },
    );
  }

  Widget _statusBadge(String status) {
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
