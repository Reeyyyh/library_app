import 'package:get/get.dart';

import '../controllers/update_category_controller.dart';

class UpdateCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCategoryController>(
      () => UpdateCategoryController(),
    );
  }
}
