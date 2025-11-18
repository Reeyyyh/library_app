import 'package:get/get.dart';

import '../controllers/list_faq_controller.dart';

class ListFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListFaqController>(
      () => ListFaqController(),
    );
  }
}
