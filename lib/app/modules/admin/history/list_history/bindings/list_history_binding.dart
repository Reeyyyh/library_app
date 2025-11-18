import 'package:get/get.dart';

import '../controllers/list_history_controller.dart';

class ListHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListHistoryController>(
      () => ListHistoryController(),
    );
  }
}
