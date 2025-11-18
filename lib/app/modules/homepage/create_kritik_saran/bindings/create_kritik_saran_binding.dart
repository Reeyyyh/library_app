import 'package:get/get.dart';

import '../controllers/create_kritik_saran_controller.dart';

class CreateKritikSaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateKritikSaranController>(
      () => CreateKritikSaranController(),
    );
  }
}
