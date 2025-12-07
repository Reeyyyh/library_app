import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

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

  // ============================
  // UPDATE PROFILE (SUPABASE)
  // ============================
  Future<void> updateProfile() async {
    try {
      final uid = auth.userModel.value!.id;

      await supabase.from('users').update({
        "name": nameC.text.trim(),
        "kelas": kelasC.text.trim(),
        "kontak": kontakC.text.trim(),
        // email tidak diupdate karena harus via Supabase Auth API jika mau ubah
      }).eq('id', uid);

      // Refresh user di AuthService
      await auth.fetchUserData(uid);

      Get.back();
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
