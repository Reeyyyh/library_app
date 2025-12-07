import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/widgets/history_card.dart';
import 'package:library_app/app/modules/client/users/widgets/history_empty.dart';
import 'package:library_app/app/modules/client/users/pages/3_History/controllers/history_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

//View yang menampilkan riwayat peminjaman buku oleh pengguna.
class HistoryView extends StatelessWidget {
  HistoryView({super.key});
  //fungsi untuk menampilkan history peminjaman buku
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'Riwayat Peminjaman',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchHistory,
          child: controller.borrowHistory.isEmpty
              ? const HistoryEmpty()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.borrowHistory.length,
                  itemBuilder: (context, index) {
                    final item = controller.borrowHistory[index];
                    return HistoryCard(data: item);
                  },
                ),
        );
      }),
    );
  }
}
// merge