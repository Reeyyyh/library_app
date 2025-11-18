import 'package:get/get.dart';

import '../controllers/update_user_controller.dart';

class UpdateUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserController>(
      () => UpdateUserController(),
    );
  }
}
