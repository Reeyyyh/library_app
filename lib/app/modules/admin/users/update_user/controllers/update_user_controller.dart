import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString nameError = ''.obs;
  RxString kelasError = ''.obs;
  RxString kontakError = ''.obs;
  RxString emailError = ''.obs;
  RxString userId = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    userId.value = data['documentId'];
    nameController.text = data['data']['name'] ?? '';
    kelasController.text = data['data']['kelas'] ?? '';
    kontakController.text = data['data']['kontak'] ?? '';
    emailController.text = data['data']['email'] ?? '';
  }

  onSubmit() {
    if (nameController.text.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
    } else if (kelasController.text.isEmpty) {
      kelasError.value = 'Kelas tidak boleh kosong';
    } else if (kontakController.text.isEmpty) {
      kontakError.value = 'Kontak tidak boleh kosong';
    } else if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else {
      isLoading.value = true;
      FirebaseFirestore.instance.collection('users').doc(userId.value).update({
        'name': nameController.text,
        'kelas': kelasController.text,
        'kontak': kontakController.text,
      }).then((value) {
        isLoading.value = false;
        Get.back();
        Get.snackbar(
          'Success',
          'Berhasil mengubah data',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }).catchError((onError) {
        isLoading.value = false;
        Get.snackbar('Error', onError.toString());
      });
    }
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
