import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KoleksiController extends GetxController {
  var category = ''.obs; // Menyimpan kategori yang diterima
  final count = 0.obs;
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  RxString categoryName = ''.obs;
  RxString categoryId = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setCategory(String name, String id) {
    categoryName.value = name;
    categoryId.value = id;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    // Tambahkan print untuk memastikan controller siap digunakan
    print("KoleksiController is ready");
  }

  @override
  void onClose() {
    super.onClose();
    // Tambahkan print untuk memeriksa ketika controller ditutup
  }

  void increment() => count.value++;
}
