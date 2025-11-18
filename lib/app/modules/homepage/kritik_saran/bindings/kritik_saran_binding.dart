import 'package:get/get.dart';

import '../controllers/kritik_saran_controller.dart';

class KritikSaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KritikSaranController>(
      () => KritikSaranController(),
    );
  }
}
