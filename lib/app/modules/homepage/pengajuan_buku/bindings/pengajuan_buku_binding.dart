import 'package:get/get.dart';

import '../controllers/pengajuan_buku_controller.dart';

class PengajuanBukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengajuanBukuController>(
      () => PengajuanBukuController(),
    );
  }
}
