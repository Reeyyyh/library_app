import 'package:get/get.dart';

import '../controllers/create_book_controller.dart';

class CreateBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBookController>(
      () => CreateBookController(),
    );
  }
}
