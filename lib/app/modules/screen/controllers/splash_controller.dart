import 'dart:async';
import 'package:get/get.dart';
import 'package:library_app/app/modules/screen/welcome_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Timer(const Duration(seconds: 5), () {
      Get.offAll(() => WelcomeView());
    });
  }
}
