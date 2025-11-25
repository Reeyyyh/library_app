import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/app/modules/homepage/home/controllers/home_controller.dart';
import 'package:library_app/app/modules/homepage/profile/controllers/profile_controller.dart';
import 'package:library_app/app/services/cloudinary_services.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  RxString imageUrl = ''.obs;
  RxString imagePath = ''.obs;
  final authC = Get.find<AuthController>();

  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  RxString nameError = ''.obs;
  RxString emailError = ''.obs;
  RxString kelasError = ''.obs;
  RxString kontakError = ''.obs;
  RxString alamatError = ''.obs;

  RxString userEmail = ''.obs;
  final box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUserData();
    userEmail.value = box.read('email') ?? '';
  }

  getUserData() async {
    isFetching.value = true;
    var user = await authC.userLoggedIn();
    nameController.text = user['name'] ?? '';
    emailController.text = user['email'] ?? '';
    kelasController.text = user['kelas'] ?? '';
    kontakController.text = user['kontak'] ?? '';
    imageUrl.value = user['image'] ?? '';
    isFetching.value = false;
  }

  onSubmit() async {
    if (nameController.text.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
    } else {
      nameError.value = '';
    }
    if (kelasController.text.isEmpty) {
      kelasError.value = 'Kelas tidak boleh kosong';
    } else {
      kelasError.value = '';
    }
    if (kontakController.text.isEmpty) {
      kontakError.value = 'Kontak tidak boleh kosong';
    } else {
      kontakError.value = '';
    }
    if (alamatController.text.isEmpty) {
      alamatError.value = 'Alamat tidak boleh kosong';
    } else {
      alamatError.value = '';
    }
    if (nameController.text.isNotEmpty &&
        kelasController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        kontakController.text.isNotEmpty) {
      isLoading.value = true;
      if (imagePath.value.isNotEmpty) {
        imageUrl.value = await uploadFileToCloudinary(File(imagePath.value));
      }
      var data = {
        'name': nameController.text,
        'kelas': kelasController.text,
        'kontak': kontakController.text,
        'image': imageUrl.value,
        'alamat': alamatController.text,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail.value)
          .update(data)
          .then(
        (value) {
          Get.back();
          Get.find<ProfileController>().getUserData();
          Get.find<HomeController>().getUserData();
          Get.snackbar('Success', 'Profile updated',
              backgroundColor: Colors.green, colorText: Colors.white);
        },
      );
      isLoading.value = false;
    }
  }

  Future<void> pickMedia(ImageSource source) async {
    XFile? pickedFile;

    pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void increment() => count.value++;
}
