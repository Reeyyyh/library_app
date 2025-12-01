import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateKritikSaranController extends GetxController {
  TextEditingController kritikController = TextEditingController();
  TextEditingController saranController = TextEditingController();
  RxString email = ''.obs;
  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxString kritikError = ''.obs;
  RxString saranError = ''.obs;

  onSubmit() async {
    if (kritikController.text.isEmpty) {
      kritikError.value = 'Kritik tidak boleh kosong';
    } else {
      kritikError.value = '';
    }
    if (saranController.text.isEmpty) {
      saranError.value = 'Saran tidak boleh kosong';
    } else {
      saranError.value = '';
    }

    if (kritikController.text.isNotEmpty && saranController.text.isNotEmpty) {
      try {
        isLoading.value = true;
        var data = {
          'kritik': kritikController.text,
          'saran': saranController.text,
          'email': email.value,
          'created_at': DateTime.now(),
        };

        FirebaseFirestore.instance.collection('kritik_saran').add(data).then(
          (value) {
            Get.back();
            Get.snackbar(
              'Berhasil',
              'Kritik & Saran berhasil dikirim',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            kritikController.clear();
            saranController.clear();
            isLoading.value = false;
          },
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    email.value = box.read('email');
    super.onInit();
  }

  void increment() => count.value++;
}
