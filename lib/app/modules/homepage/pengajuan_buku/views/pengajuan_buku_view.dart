import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/pengajuan_buku_controller.dart';

class PengajuanBukuView extends GetView<PengajuanBukuController> {
  const PengajuanBukuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pengajuan Buku'),
      body: const Center(
        child: Text(
          'PengajuanBukuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/pengajuan-buku/create'),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
