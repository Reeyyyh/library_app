import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFaqController extends GetxController {
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString judulError = ''.obs;
  RxString deskripsiError = ''.obs;

  onSubmit() {
    if (judulController.text.isEmpty) {
      judulError.value = 'Judul tidak boleh kosong';
    } else {
      judulError.value = '';
    }

    if (deskripsiController.text.isEmpty) {
      deskripsiError.value = 'Deskripsi tidak boleh kosong';
    } else {
      deskripsiError.value = '';
    }

    if (judulController.text.isNotEmpty &&
        deskripsiController.text.isNotEmpty) {
      isLoading.value = true;
      FirebaseFirestore.instance.collection('faq').add({
        'judul': judulController.text,
        'deskripsi': deskripsiController.text,
        'createdAt': DateTime.now(),
      }).then((value) {
        isLoading.value = false;
        Get.back();
        Get.snackbar('Berhasil', 'FAQ berhasil ditambahkan',
            backgroundColor: Colors.green, colorText: Colors.white);
      });
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
