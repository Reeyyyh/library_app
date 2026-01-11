import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/views/admin_loan_request_list_view.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/views/admin_user_management_view.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';

class Other extends StatelessWidget {
  const Other({super.key});
// Build method untuk membangun tampilan halaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Lainnya",
        showBack: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuTile(
            icon: Icons.assignment,
            title: "Pengajuan Peminjaman",
            subtitle: "Terima atau tolak permintaan",
            onTap: () {
              Get.to(() => AdminLoanRequestListView());
            },
          ),
          _menuTile(
            icon: Icons.people,
            title: "Kelola Pengguna",
            subtitle: "Manajemen akun pengguna",
            onTap: () {
              Get.to(() => AdminUserManagementView());
            },
          ),
          _menuTile(
            icon: Icons.settings,
            title: "Pengaturan",
            subtitle: "Pengaturan sistem",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
