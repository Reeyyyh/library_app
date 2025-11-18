import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LainnyaController extends GetxController {
  var menus = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    menus.value = [
      {
        'title': 'Riwayat',
        'icon': Icons.history,
        'route': '/list-history',
      },
      {
        'title': 'Kritik & Saran',
        'icon': Icons.feedback,
        'route': '/kritik-saran-admin',
      },
      {
        'title': 'Pengajuan Buku',
        'icon': Icons.book,
        'route': '/pengajuan-buku-admin',
      },
      {
        'title': 'FAQ',
        'icon': Icons.question_answer,
        'route': '/list-faq',
      },
    ];
  }
}
