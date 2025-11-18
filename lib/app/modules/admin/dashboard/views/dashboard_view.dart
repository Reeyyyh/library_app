import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.name.value.isNotEmpty
                        ? 'Welcome, ${controller.name.value}'
                        : '-',
                    style: AppTheme.heading1.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
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
                        Text(
                          'Are you sure you want to logout?',
                          style: AppTheme.heading2.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: AppTheme.bodyText.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                Get.find<AuthController>().logout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                              ),
                              child: Text(
                                'Logout',
                                style: AppTheme.bodyText.copyWith(
                                  color: Colors.white,
                                ),
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
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  controller.name.value[0],
                  style: AppTheme.heading1.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          return controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Text(
                      'Selamat datang, kelola dan pantau aktivitas perpustakaan dengan mudah.',
                      style: AppTheme.heading3.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Pilih menu yang ingin Anda kelola.',
                      style: AppTheme.caption.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.menus.length,
                      itemBuilder: (context, index) {
                        var item = controller.menus[index];
                        Color containerColor = Color(0xFF009140);
                        return GestureDetector(
                          onTap: () {
                            if (index == 2) {
                              Get.toNamed('/list-history');
                            } else {
                              Get.find<LayoutController>()
                                  .changeTabIndex(index + 1);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item['title'].toString(),
                                        style: AppTheme.heading3.copyWith(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      ClipOval(
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(6),
                                          child: Icon(
                                            size: 24,
                                            item['icon'] as IconData,
                                            color: containerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item['count'].toString(),
                                        style: AppTheme.heading1.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item['unit'].toString(),
                                        style: AppTheme.bodyText.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Daftar Pengajuan',
                      style: AppTheme.bodyText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
        },
      ),
    );
  }
}
