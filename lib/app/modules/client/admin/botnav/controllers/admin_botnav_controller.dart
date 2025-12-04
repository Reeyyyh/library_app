import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/1_Dashboard/views/dashboard_view.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/views/listbook_view.dart';
import 'package:library_app/app/modules/client/admin/pages/3_ListCategory/views/listcategory_view.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/views/other_view.dart';

// Controller untuk Bottom Navigation Admin gunakan GetX
class AdminBotnavController extends GetxController {

  RxInt selectedIndex = 0.obs;        // Menyimpan index tab navigation yang sedang aktif

  // List menu navigasi admin berisi icon, title dan halaman yang dituju
  final List<Map<String, dynamic>> adminMenus = [
    {
      'title': 'Dashboard',           // Menu Dashboard
      'icon': Icons.home,             // Icon Home untuk Dashboard
      'page': DashboardView(),        // Halaman Dashboard
    },
    {
      'title': 'Buku',                // Menu List Buku
      'icon': Icons.my_library_books_rounded, // Icon untuk menu Buku
      'page': ListBook(),             // Halaman List Buku
    },
    {
      'title': 'Kategori',            // Menu List Kategori Buku
      'icon': Icons.category_rounded, // Icon untuk menu Kategori
      'page': ListCategory(),         // Halaman List Kategori
    },
    {
      'title': 'Lainnya',             // Menu bagian lainnya
      'icon': Icons.more_horiz,       // Icon titik tiga horizontal
      'page': Other(),                // Halaman Menu Lainnya
    },
  ];

  List<Map<String, dynamic>> get menus => adminMenus; // Getter memudahkan akses daftar menu

  void changeTabIndex(int index) {    // Method untuk mengubah tab bottom nav
    if (selectedIndex.value == index) return;  // Jika index sama, tidak perlu update
    selectedIndex.value = index;      // Update index menu yang dipilih
  }
}
