import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  RxString name = ''.obs;
  GetStorage box = GetStorage();
  RxBool isLoading = false.obs;

  var menus = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    name.value = box.read('name');
    getDataCount();
  }

  getDataCount() async {
    isLoading.value = true;
    var bookCount, categoryCount, historyCount, userCount;
    await FirebaseFirestore.instance.collection('books').get().then((value) {
      bookCount = value.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      categoryCount = value.docs.length;
    });
    await FirebaseFirestore.instance.collection('history').get().then((value) {
      historyCount = value.docs.length;
    });
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      userCount = value.docs.length;
    });

    menus.value = [
      {
        'title': 'Buku',
        'count': bookCount,
        'icon': Icons.book_outlined,
        'unit': 'buah',
      },
      {
        'title': 'Kategori',
        'count': categoryCount,
        'icon': Icons.category_outlined,
        'unit': 'jenis',
      },
      {
        'title': 'Riwayat',
        'count': historyCount,
        'icon': Icons.history_rounded,
        'unit': 'data',
      },
      {
        'title': 'Pengguna',
        'count': userCount,
        'icon': Icons.person_outline_rounded,
        'unit': 'orang',
      },
    ];
    isLoading.value = false;
  }
}
