import 'package:get/get.dart';

/// Controller for handling login validation
class LoginController extends GetxController {
  var emailError = ''.obs;
  var passwordError = ''.obs;

  var emailSuccess = false.obs;
  var passwordSuccess = false.obs;

  bool validate(String email, String password) {
    bool isValid = true;

    // reset
    emailError.value = '';
    passwordError.value = '';
    emailSuccess.value = false;
    passwordSuccess.value = false;

    // Email
    if (email.trim().isEmpty) {
      emailError.value = "Email wajib diisi";
      isValid = false;
    } else if (!email.contains("@")) {
      emailError.value = "Format email tidak valid";
      isValid = false;
    } else {
      emailSuccess.value = true;
    }

    // Password
    if (password.trim().isEmpty) {
      passwordError.value = "Password wajib diisi";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Minimal 6 karakter";
      isValid = false;
    } else {
      passwordSuccess.value = true;
    }

    return isValid;
  }
}
