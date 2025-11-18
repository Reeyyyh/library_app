import 'package:get/get.dart';

import '../controllers/create_faq_controller.dart';

class CreateFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateFaqController>(
      () => CreateFaqController(),
    );
  }
}
