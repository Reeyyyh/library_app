import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxString name = 'Admin'.obs;
  RxBool isLoading = false.obs;

  // Dummy menu data
  RxList<Map<String, dynamic>> menus = <Map<String, dynamic>>[
    {
      'title': 'Buku',
      'icon': Icons.book_outlined,
      'count': 10,
      'unit': 'Buah',
    },
    {
      'title': 'Kategori',
      'icon': Icons.category_outlined,
      'count': 25,
      'unit': 'Jenis',
    },
    {
      'title': 'Riwayat',
      'icon': Icons.history_rounded,
      'count': 5,
      'unit': 'Dat',
    },
    {
      'title': 'Pengguna',
      'icon': Icons.person_outline_rounded,
      'count': 50,
      'unit': 'Orang',
    },
  ].obs;

  // Dummy loan requests
  RxList<Map<String, String>> loanRequests = <Map<String, String>>[
    {
      'nama': 'Rifki Ramadany',
      'email': 'rifki@mail.com',
      'judulBuku': 'Flutter for Beginners',
      'category': 'Programming',
      'tanggalPinjam': '2025-11-20',
      'tanggalKembali': '2025-11-25',
      'status': 'Pending',
    },
    {
      'nama': 'Siti Nurhaliza',
      'email': 'siti@mail.com',
      'judulBuku': 'Dart in Action',
      'category': 'Programming',
      'tanggalPinjam': '2025-11-18',
      'tanggalKembali': '2025-11-23',
      'status': 'Pending',
    },
  ].obs;
}
