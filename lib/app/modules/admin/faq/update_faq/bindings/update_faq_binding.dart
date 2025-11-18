import 'package:get/get.dart';

import '../controllers/update_faq_controller.dart';

class UpdateFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateFaqController>(
      () => UpdateFaqController(),
    );
  }
}
