import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/widgets/load_request_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomAppTheme.primaryColor, // primary color
        title: Obx(() => Text(
              'Welcome, ${controller.name.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        actions: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              controller.logout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomAppTheme.primaryColor,
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Obx(() => Text(
                    controller.name.value[0],
                    style: const TextStyle(
                      color: CustomAppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 16),
        ],
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
                                item['title'],
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
                                    item['icon'],
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
                                item['count'].toString(),
                                style: CustomAppTheme.heading1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item['unit'],
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
                  return Column(
                    children: controller.loanRequests
                        .map((item) => LoanRequestCard(
                              data: item,
                              onTap: () {
                                // nanti bisa ke halaman detail pinjam
                                print('Tapped on ${item['nama']}');
                              },
                            ))
                        .toList(),
                  );
                }),
              ],
            ),
          ],
        );
      }),
    );
  }
}
