import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/views/home_view.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/collection_view.dart';
import 'package:library_app/app/modules/client/users/pages/3_history/views/history_view.dart';
import 'package:library_app/app/modules/client/users/pages/4_Profile/views/profile_view.dart';

class UserBotNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var selectedCategory = Rx<CategoryModel?>(null);

  final List<Map<String, dynamic>> userMenus = [
    {
      'title': 'Beranda',
      'icon': Icons.home_outlined,
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
      'icon': Icons.history_toggle_off,
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
    // selectedCategory.value = null;
  }

  void goToCollectionByCategory(CategoryModel category) {
    selectedCategory.value = category;
    selectedIndex.value = 1;
  }
}
// merge
