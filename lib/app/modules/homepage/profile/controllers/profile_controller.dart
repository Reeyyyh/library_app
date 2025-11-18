import 'package:get/get.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final authC = Get.find<AuthController>();
  Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  getUserData() async {
    isLoading.value = true;
    user.value = await authC.getUserData();
    isLoading.value = false;
  }
}
