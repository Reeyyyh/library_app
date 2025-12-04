import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/botnav/controllers/admin_botnav_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class AdminBotNavView extends StatelessWidget {
  const AdminBotNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminBotnavController()); // Inisialisasi controller bottom navigation Admin

    return Scaffold(
      body: Obx(() => controller.menus[controller.selectedIndex.value]['page']), // Menampilkan halaman sesuai tab terpilih

      bottomNavigationBar: Obx(
        () => Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20), // Sudut atas navigation dibulatkan
            ),
          ),

          // Row menu navigasi
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Menu diposisikan rata tengah secara merata
            children: List.generate(
              controller.menus.length, // Membuat item nav sesuai jumlah menu
              (index) => GestureDetector(
                onTap: () => controller.changeTabIndex(index), // Ganti tab saat ditekan

                // Icon dan label menu
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? CustomAppTheme.primaryColor // Warna aktif menu
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Icon(
                        controller.menus[index]['icon'], // Menampilkan icon dari list menu
                        color: controller.selectedIndex.value == index
                            ? Colors.white
                            : Colors.black, // Ganti warna icon saat aktif / tidak
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      controller.menus[index]['title'], // Label menu
                      style: TextStyle(
                        fontWeight: controller.selectedIndex.value == index
                            ? FontWeight.bold // Title bold jika aktif
                            : FontWeight.normal,
                        color: controller.selectedIndex.value == index
                            ? CustomAppTheme.primaryColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
