import 'package:get/get.dart';

import '../controllers/update_book_controller.dart';

class UpdateBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateBookController>(
      () => UpdateBookController(),
    );
  }
}
