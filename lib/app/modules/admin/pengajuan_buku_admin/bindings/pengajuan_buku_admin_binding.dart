import 'package:get/get.dart';

import '../controllers/pengajuan_buku_admin_controller.dart';

class PengajuanBukuAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengajuanBukuAdminController>(
      () => PengajuanBukuAdminController(),
    );
  }
}
