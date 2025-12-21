import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/1_Dashboard/controllers/dashboard_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

// Widget AppBar khusus untuk halaman Admin
// Mengimplementasikan PreferredSizeWidget agar dapat digunakan sebagai AppBar
class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Judul AppBar
  final String title;

  // Menentukan apakah teks "Welcome, {nama}" ditampilkan
  final bool showWelcome;

  // Menentukan apakah tombol back ditampilkan
  final bool showBack;

  // Konstruktor AdminAppBar
  const AdminAppBar({
    super.key,
    required this.title,
    this.showWelcome = false,
    this.showBack = true,
  });

  // Mengatur tinggi AppBar (standar toolbar)
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // Membangun tampilan AppBar
  @override
  Widget build(BuildContext context) {
    // Mengambil DashboardController jika sudah terdaftar di GetX
    // Jika belum terdaftar, nilai dashboard akan null
    final DashboardController? dashboard =
        Get.isRegistered<DashboardController>()
            ? Get.find<DashboardController>()
            : null;

    return AppBar(
      // Warna latar belakang AppBar
      backgroundColor: CustomAppTheme.primaryColor,

      // Tombol kembali (back) ditampilkan jika showBack bernilai true
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(), // Navigasi kembali ke halaman sebelumnya
            )
          : null,

      // Judul AppBar
      // Jika showWelcome aktif dan controller tersedia, tampilkan teks sambutan
      title: (showWelcome && dashboard != null)
          ? Obx(() => Text(
                "Welcome, ${dashboard.name.value}", // Nama admin dari controller
                style: _titleStyle(),
              ))
          : Text(
              title, // Judul statis
              style: _titleStyle(),
            ),

      // Action di sebelah kanan AppBar
      actions: [
        GestureDetector(
          // Ketika avatar ditekan, tampilkan bottom sheet logout
          onTap: () =>
              dashboard != null ? _showLogoutSheet(dashboard) : null,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: CustomAppTheme.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // Style teks judul AppBar
  TextStyle _titleStyle() => const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  // Menampilkan Bottom Sheet konfirmasi logout
  void _showLogoutSheet(DashboardController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Teks konfirmasi logout
            const Text(
              "Are you sure you want to logout?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Tombol aksi logout
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol batal
                OutlinedButton(
                  onPressed: () => Get.back(), // Menutup bottom sheet
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 8),

                // Tombol logout
                ElevatedButton(
                  onPressed: () async {
                    Get.back(); // Menutup bottom sheet
                    controller.logout(); // Proses logout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomAppTheme.primaryColor,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
