import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/routes/app_pages.dart'; // Sesuaikan dengan routing kamu
import 'package:library_app/app/modules/auth/views/login_view.dart';

class RegisterController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  // ===========================
  // Text Controllers
  // ===========================
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  // ===========================
  // Reactive Variables
  // ===========================
  var isLoading = false.obs;

  // Menggunakan RxnString (Nullable). Jika null = tidak ada error.
  var nameError = RxnString();
  var emailError = RxnString();
  var passwordError = RxnString();
  var confirmPasswordError = RxnString();

  // Indikator Sukses (Opsional, untuk UI feedback warna hijau)
  var nameSuccess = false.obs;
  var emailSuccess = false.obs;
  var passwordSuccess = false.obs;
  var confirmPasswordSuccess = false.obs;

  @override
  void onClose() {
    // Bersihkan controller dari memori saat halaman ditutup
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }

  // ===========================
  // Fungsi Validasi
  // ===========================
  bool validate() {
    bool isValid = true;

    // Ambil value dari controller
    String name = nameC.text.trim();
    String email = emailC.text.trim();
    String password = passwordC.text;
    String confirmPassword = confirmPasswordC.text;

    // Reset State
    _resetValidationState();

    // 1. Validasi Nama
    if (name.isEmpty) {
      nameError.value = "Nama tidak boleh kosong";
      isValid = false;
    } else {
      nameSuccess.value = true;
    }

    // 2. Validasi Email
    if (email.isEmpty) {
      emailError.value = "Email wajib diisi";
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Format email tidak valid";
      isValid = false;
    } else {
      emailSuccess.value = true;
    }

    // 3. Validasi Password
    if (password.isEmpty) {
      passwordError.value = "Password wajib diisi";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Minimal 6 karakter";
      isValid = false;
    } else {
      passwordSuccess.value = true;
    }

    // 4. Validasi Konfirmasi Password
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Konfirmasi wajib diisi";
      isValid = false;
    } else if (confirmPassword != password) {
      confirmPasswordError.value = "Password tidak sama";
      isValid = false;
    } else {
      confirmPasswordSuccess.value = true;
    }

    return isValid;
  }

  void _resetValidationState() {
    nameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;

    nameSuccess.value = false;
    emailSuccess.value = false;
    passwordSuccess.value = false;
    confirmPasswordSuccess.value = false;
  }

  // ===========================
  // Fungsi Register
  // ===========================
  Future<void> doRegister() async {
    // Lakukan validasi dulu sebelum request ke server
    if (!validate()) return;

    try {
      isLoading.value = true;

      String? result = await _auth.register(
        name: nameC.text.trim(),
        email: emailC.text.trim(),
        password: passwordC.text,
      );

      isLoading.value = false;

      if (result != null) {
        // Gagal (Result berisi pesan error dari service)
        Get.snackbar(
          "Registrasi Gagal",
          result,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
        );
      } else {
        // Sukses
        Get.snackbar(
          "Berhasil",
          "Akun berhasil dibuat, silakan login",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
        );

        // Reset form agar bersih jika user kembali (opsional)
        nameC.clear();
        emailC.clear();
        passwordC.clear();
        confirmPasswordC.clear();
        _resetValidationState();

        Get.offAll(() => LoginView());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Terjadi kesalahan sistem");
    }
  }
}
