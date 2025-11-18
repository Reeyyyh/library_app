import 'package:get/get.dart';

import '../controllers/list_categories_controller.dart';

class ListCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListCategoriesController>(
      () => ListCategoriesController(),
    );
  }
}
