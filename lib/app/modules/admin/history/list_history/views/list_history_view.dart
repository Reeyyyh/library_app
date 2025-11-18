import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/list_history_controller.dart';

class ListHistoryView extends GetView<ListHistoryController> {
  const ListHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Daftar Riwayat'),
      body: const Center(
        child: Text(
          'ListHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
