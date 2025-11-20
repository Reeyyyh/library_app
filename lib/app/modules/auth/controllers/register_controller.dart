import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Error state reactive
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  var nameSuccess = false.obs;
  var emailSuccess = false.obs;
  var passwordSuccess = false.obs;
  var confirmPasswordSuccess = false.obs;

  bool validate({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    bool isValid = true;

    name = name.trim();
    email = email.trim();

    // RESET error
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    // RESET success
    nameSuccess.value = false;
    emailSuccess.value = false;
    passwordSuccess.value = false;
    confirmPasswordSuccess.value = false;

    // NAME
    if (name.isEmpty) {
      nameError.value = "Nama tidak boleh kosong";
      isValid = false;
    } else {
      nameSuccess.value = true;
    }

    // EMAIL
    if (email.isEmpty) {
      emailError.value = "Email wajib diisi";
      isValid = false;
    } else if (!email.contains("@")) {
      emailError.value = "Format email tidak valid";
      isValid = false;
    } else {
      emailSuccess.value = true;
    }

    // PASSWORD
    if (password.isEmpty) {
      passwordError.value = "Password wajib diisi";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Minimal 6 karakter";
      isValid = false;
    } else {
      passwordSuccess.value = true;
    }

    // CONFIRM PASSWORD
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Konfirmasi wajib diisi";
      isValid = false;
    } else if (confirmPassword.length < 6) {
      confirmPasswordError.value = "Minimal 6 karakter";
      isValid = false;
    } else if (confirmPassword != password) {
      confirmPasswordError.value = "Konfirmasi tidak sesuai";
      isValid = false;
    } else {
      confirmPasswordSuccess.value = true;
    }

    return isValid;
  }
}
