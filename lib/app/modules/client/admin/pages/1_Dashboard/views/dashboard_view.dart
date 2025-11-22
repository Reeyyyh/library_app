import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/client/admin/widgets/load_request_card.dart';
import 'package:library_app/app/modules/client/admin/widgets/load_request_empty.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      appBar: AdminAppBar(
        title: "Dashboard",
        showWelcome: true,
        showBack: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 10),
            Text(
              'Selamat datang, kelola dan pantau aktivitas perpustakaan dengan mudah.',
              style: CustomAppTheme.heading3.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Pilih menu yang ingin Anda kelola.',
              style: CustomAppTheme.caption.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: controller.menus.length,
              itemBuilder: (context, index) {
                final item = controller.menus[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomAppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title, // dari model
                                style: CustomAppTheme.heading3.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    item.icon, // dari model
                                    size: 24,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                item.count.toString(), // dari model
                                style: CustomAppTheme.heading1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.unit, // dari model
                                style: CustomAppTheme.bodyText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar Pengajuan',
                  style: CustomAppTheme.bodyText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.loanRequests.isEmpty) {
                    return const LoadRequestEmpty();
                  }

                  return Column(
                    children: controller.loanRequests
                        .map((request) => LoanRequestCard(
                              data: request,
                              onTap: () {
                                // bisa nanti ke detail page
                                print('Tapped ${request.nama}');
                              },
                            ))
                        .toList(),
                  );
                }),
              ],
            )
          ],
        );
      }),
    );
  }
}
