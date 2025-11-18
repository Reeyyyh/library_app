import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

class WelcomeController extends GetxController {
  final authC = Get.find<AuthController>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Delay sebentar supaya Firebase Auth siap
    Future.delayed(Duration(milliseconds: 100), () => checkUser());
  }

  Future<void> checkUser() async {
    try {
      // Ambil user saat ini dari AuthController
      User? user = authC.user;

      if (user != null) {
        // Ambil data user dari Firestore
        var authData = await authC.getUserData();

        if (authData != null) {
          // Simpan ke GetStorage
          box.write('name', authData['name']);
          box.write('email', authData['email']);
          box.write('id', authData['id']);
          box.write('role', authData['role']);

          // Navigasi setelah data siap
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Get.currentRoute != '/layout') {
              Get.offAllNamed('/layout');
            }
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
