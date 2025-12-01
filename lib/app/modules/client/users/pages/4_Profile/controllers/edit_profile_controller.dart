import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';

class EditProfileController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController kelasC;
  late TextEditingController kontakC;

  @override
  void onInit() {
    final user = auth.userModel.value;

    nameC = TextEditingController(text: user?.name ?? '');
    emailC = TextEditingController(text: user?.email ?? '');
    kelasC = TextEditingController(text: user?.kelas ?? '');
    kontakC = TextEditingController(text: user?.kontak ?? '');

    super.onInit();
  }

  Future<void> updateProfile() async {
    try {
      final uid = auth.firebaseUser.value!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        "name": nameC.text.trim(),
        "kelas": kelasC.text.trim(),
        "kontak": kontakC.text.trim(),
        // email tidak diedit karena FirebaseAuth wajib update via method khusus
      });

      // refresh data user di AuthService
      await auth.fetchUserData(uid);

      Get.back(); // kembali ke ProfileView
      Get.snackbar(
        "Sukses",
        "Profil berhasil diperbarui",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal update profil: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    kelasC.dispose();
    kontakC.dispose();
    super.onClose();
  }
}
// merge