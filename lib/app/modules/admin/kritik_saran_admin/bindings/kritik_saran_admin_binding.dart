import 'package:get/get.dart';

import '../controllers/kritik_saran_admin_controller.dart';

class KritikSaranAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KritikSaranAdminController>(
      () => KritikSaranAdminController(),
    );
  }
}
