import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/setting_admin_controller.dart';

class SettingAdminView extends GetView<SettingAdminController> {
  const SettingAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Menu Lainnya'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              children: [
                buildListTile(
                  '/list-user',
                  'Pengguna',
                  Icons.group,
                ),
                buildListTile(
                  '/kritik-saran-admin',
                  'Kritik & Saran',
                  Icons.message_outlined,
                ),
                buildListTile(
                  '/list-history',
                  'Riwayat Peminjaman',
                  Icons.history,
                ),
                buildListTile(
                  '/list-faq',
                  'Paling Sering Ditanyakan',
                  Icons.question_answer_outlined,
                ),
                buildListTile(
                  '/pengajuan-buku-admin',
                  'Pengajuan Buku',
                  Icons.book_outlined,
                ),
                buildListTile(
                  '/list-testimoni',
                  'Testimoni',
                  Icons.star_rate_rounded,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.find<AuthController>().logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Keluar',
                      style: AppTheme.heading1
                          .copyWith(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListTile(String route, String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () => Get.toNamed(route),
        leading: Icon(icon),
        title: Text(
          title,
          style: AppTheme.heading2.copyWith(
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ),
    );
  }
}
