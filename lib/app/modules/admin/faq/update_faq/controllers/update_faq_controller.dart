import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateFaqController extends GetxController {
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString judulError = ''.obs;
  RxString deskripsiError = ''.obs;
  RxString faqId = ''.obs;

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
      FirebaseFirestore.instance.collection('faq').doc(faqId.value).update({
        'judul': judulController.text,
        'deskripsi': deskripsiController.text,
      }).then((value) {
        isLoading.value = false;
        Get.back();
        Get.snackbar('Berhasil', 'FAQ berhasil diupdate',
            backgroundColor: Colors.green, colorText: Colors.white);
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    judulController.text = data['data']['judul'];
    deskripsiController.text = data['data']['deskripsi'];
    faqId.value = data['documentId'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
