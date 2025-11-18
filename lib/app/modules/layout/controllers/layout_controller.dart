import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/app/modules/admin/books/list_book/views/list_book_view.dart';
import 'package:library_app/app/modules/admin/categories/list_categories/views/list_categories_view.dart';
import 'package:library_app/app/modules/admin/dashboard/views/dashboard_view.dart';
import 'package:library_app/app/modules/admin/users/list_user/views/list_user_view.dart';
import 'package:library_app/app/modules/homepage/home/views/home_view.dart';
import 'package:library_app/app/modules/homepage/koleksi/views/koleksi_view.dart';
import 'package:library_app/app/modules/homepage/profile/views/profile_view.dart';
import 'package:library_app/app/modules/homepage/riwayat/views/riwayat_view.dart';

class LayoutController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isAdmin = false.obs;
  final box = GetStorage();
  final authC = Get.find<AuthController>();

  // Menu untuk Admin
  final List<Map<String, dynamic>> adminMenus = [
    {
      'title': 'Dashboard',
      'icon': Icons.home,
      'page': DashboardView(),
    },
    {
      'title': 'Buku',
      'icon': Icons.my_library_books_rounded,
      'page': ListBookView(),
    },
    {
      'title': 'Kategori',
      'icon': Icons.category_rounded,
      'page': ListCategoriesView(),
    },
    {
      'title': 'Pengguna',
      'icon': Icons.person,
      'page': ListUserView(),
    },
  ];

  // Menu untuk User
  final List<Map<String, dynamic>> userMenus = [
    {
      'title': 'Home',
      'icon': Icons.home,
      'page': HomeView(),
    },
    {
      'title': 'Koleksi',
      'icon': Icons.my_library_books_rounded,
      'page': KoleksiView(),
    },
    {
      'title': 'Riwayat',
      'icon': Icons.history,
      'page': RiwayatView(),
    },

    {
      'title': 'Profile',
      'icon': Icons.person,
      'page': ProfileView(),
    },
  ];

  List<Map<String, dynamic>> get menus =>
      isAdmin.value ? adminMenus : userMenus;

  var arguments = {}.obs;

  // Fungsi untuk mengganti tab
  void changeTabIndex(int index, {Map<String, dynamic>? newArguments}) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    bool isCollection = index == 1;
    if (!isAdmin.value) {
      if (!isCollection) {
        newArguments = null;
      }
    }

    if (newArguments != null) {
      arguments.value = newArguments;
    } else {
      arguments.value = {};
    }
    update();
  }

  getUserData() async {
    var data = await authC.getUserData();
    isAdmin.value = data?['role'] == 'Admin' ? true : false;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
    update();
  }
}
