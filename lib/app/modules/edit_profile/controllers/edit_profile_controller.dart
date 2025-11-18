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
  // TEXT CONTROLLERS
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final kelasController = TextEditingController();
  final kontakController = TextEditingController();

  RxBool isFetching = false.obs;

  // IMAGE
  final ImagePicker _picker = ImagePicker();
  RxString imageUrl = ''.obs;
  RxString imagePath = ''.obs;

  // AUTH
  final authC = Get.find<AuthController>();
  final box = GetStorage();

  // STATE
  RxBool isLoading = false.obs;
  RxBool isAdmin = false.obs;

  // ERROR TEXT
  RxString nameError = ''.obs;
  RxString kelasError = ''.obs;
  RxString kontakError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  // ============================================================
  // GET USER DATA FROM FIRESTORE
  // ============================================================
  Future<void> getUserData() async {
    isFetching.value = true;

    try {
      final data = await authC.getUserData();

      if (data != null) {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        kelasController.text = data['kelas'] ?? '';
        kontakController.text = data['kontak'] ?? '';
        imageUrl.value = data['image'] ?? '';
        isAdmin.value = data['role'] == 'Admin';
      }
    } finally {
      isFetching.value = false;
    }
  }

  // ============================================================
  // SUBMIT UPDATE PROFILE
  // ============================================================
  Future<void> onSubmit() async {
    // VALIDATION
    nameError.value =
        nameController.text.isEmpty ? 'Nama tidak boleh kosong' : '';

    kelasError.value =
        kelasController.text.isEmpty ? 'Kelas tidak boleh kosong' : '';

    kontakError.value =
        kontakController.text.isEmpty ? 'Kontak tidak boleh kosong' : '';

    if (nameError.isNotEmpty || kelasError.isNotEmpty || kontakError.isNotEmpty)
      return;

    isLoading.value = true;

    try {
      // Upload image jika user memilih foto baru
      if (imagePath.value.isNotEmpty) {
        imageUrl.value = await uploadFileToCloudinary(File(imagePath.value));
      }

      // Data yang akan diupdate
      final data = {
        'name': nameController.text,
        'kelas': kelasController.text,
        'kontak': kontakController.text,
        'image': imageUrl.value,
      };

      // Update Firestore berdasarkan UID user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authC.user!.uid)
          .update(data);

      // Refresh profile & home page
      Get.find<ProfileController>().getUserData();
      Get.find<HomeController>().getUserData();

      Get.back();
      Get.snackbar('Success', 'Profile updated',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Gagal update profil: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================
  Future<void> pickMedia(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }
}
