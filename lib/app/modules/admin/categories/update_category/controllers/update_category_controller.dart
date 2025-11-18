import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';

class UpdateCategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  RxString categoryId = ''.obs;
  RxBool isLoading = false.obs;
  RxString nameError = ''.obs;

  onSubmit() {
    if (nameController.text.isEmpty) {
      nameError.value = 'Nama kategori tidak boleh kosong';
    } else {
      nameError.value = '';
    }

    isLoading.value = true;
    try {
      if (nameError.value.isEmpty) {
        FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId.value)
            .update({
          'name': nameController.text,
        }).then((value) {
          Get.snackbar(
            'Success',
            'Kategori berhasil diubah',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.find<LayoutController>().selectedIndex.value = 2;
          Get.offAllNamed('/layout');
        }).catchError((error) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan saat mengubah kategori',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });
        isLoading.value = false;
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
    var arguments = Get.arguments;
    categoryId.value = arguments['documentId'];
    nameController.text = arguments['data']['name'];
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
