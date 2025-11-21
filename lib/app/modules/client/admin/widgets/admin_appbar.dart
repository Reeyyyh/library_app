import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/1_Dashboard/controllers/dashboard_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showWelcome;

  const AdminAppBar({
    super.key,
    required this.title,
    this.showWelcome = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // TRY GET → aman dipakai di halaman apa pun
    final DashboardController? dashboard =
        Get.isRegistered<DashboardController>()
            ? Get.find<DashboardController>()
            : null;

    return AppBar(
      backgroundColor: CustomAppTheme.primaryColor,

      // 🔥 TITLE reactive kalau showWelcome = true
      title: (showWelcome && dashboard != null)
          ? Obx(() => Text(
                "Welcome, ${dashboard.name.value}",
                style: _titleStyle(),
              ))
          : Text(
              title,
              style: _titleStyle(),
            ),

      actions: [
        GestureDetector(
          onTap: () => dashboard != null
              ? _showLogoutSheet(dashboard)
              : null,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,

            // 🔥 Avatar SEKARANG SELALU Icons.person
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

  TextStyle _titleStyle() => const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

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
            const Text(
              "Are you sure you want to logout?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    "Cancel",
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
