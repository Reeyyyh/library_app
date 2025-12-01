import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/1_Dashboard/views/dashboard_view.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/views/listbook_view.dart';
import 'package:library_app/app/modules/client/admin/pages/3_ListCategory/views/listcategory_view.dart';
import 'package:library_app/app/modules/client/admin/pages/4_Other/views/other_view.dart';


class AdminBotnavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Map<String, dynamic>> adminMenus = [
    {
      'title': 'Dashboard',
      'icon': Icons.home,
      'page': DashboardView(),
    },
    {
      'title': 'Buku',
      'icon': Icons.my_library_books_rounded,
      'page': ListBook(),
    },
    {
      'title': 'Kategori',
      'icon': Icons.category_rounded,
      'page': ListCategory(),
    },
    {
      'title': 'Lainnya',
      'icon': Icons.more_horiz,
      'page': Other(),
    },
  ];

  List<Map<String, dynamic>> get menus => adminMenus;

  void changeTabIndex(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }
}
// merge