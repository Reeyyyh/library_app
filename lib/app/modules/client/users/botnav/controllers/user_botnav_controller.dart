import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/views/home_view.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/collection_view.dart';
import 'package:library_app/app/modules/client/users/pages/3_history/views/history_view.dart';
import 'package:library_app/app/modules/client/users/pages/4_Profile/views/profile_view.dart';

class UserBotNavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Map<String, dynamic>> userMenus = [
    {
      'title': 'Beranda',
      // icon garis (inactive)
      'icon': Icons.home_outlined,
      // icon filled (active)
      'activeIcon': Icons.home_rounded,
      'page': HomeView(),
    },
    {
      'title': 'Koleksi',
      'icon': Icons.menu_book_outlined,
      'activeIcon': Icons.menu_book_rounded,
      'page': CollectionView(),
    },
    {
      'title': 'Riwayat',
      'icon': Icons.history_toggle_off, // boleh diganti sesuai selera
      'activeIcon': Icons.history_rounded,
      'page': HistoryView(),
    },
    {
      'title': 'Profile',
      'icon': Icons.person_outline,
      'activeIcon': Icons.person,
      'page': ProfileView(),
    },
  ];

  List<Map<String, dynamic>> get menus => userMenus;

  void changeTabIndex(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }
}
