import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/pengajuan_buku_admin_controller.dart';

class PengajuanBukuAdminView extends GetView<PengajuanBukuAdminController> {
  const PengajuanBukuAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Daftar Pengajuan Buku'),
      body: const Center(
        child: Text(
          'PengajuanBukuAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
