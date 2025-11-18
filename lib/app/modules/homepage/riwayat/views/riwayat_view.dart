import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Riwayat Saya'),
      body: const Center(
        child: Text(
          'RiwayatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
