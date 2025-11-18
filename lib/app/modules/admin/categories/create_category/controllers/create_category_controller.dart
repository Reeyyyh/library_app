import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';

class CreateCategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();

  RxString nameError = ''.obs;
  RxBool isLoading = false.obs;

  onSubmit() {
    if (nameController.text.isEmpty) {
      nameError.value = 'Nama kategori tidak boleh kosong';
    } else {
      nameError.value = '';
    }
    isLoading.value = true;
    try {
      if (nameError.value.isEmpty) {
        FirebaseFirestore.instance.collection('categories').add({
          'name': nameController.text,
          'createdAt': DateTime.now(),
        }).then((value) {
          Get.snackbar(
            'Succes',
            'Kategori berhasil ditambahkan',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.find<LayoutController>().selectedIndex.value = 2;
          Get.offNamed('/layout');
        }).catchError((e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan saat menambahkan kategori',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat menambahkan kategori',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
