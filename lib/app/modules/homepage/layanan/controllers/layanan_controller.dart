import 'package:get/get.dart';

class LayananController extends GetxController {
  var menus = [
    {
      "title": "Kritik dan Saran",
      "icon": "assets/opinion.png",
      "route": "/kritik-saran"
    },
    {
      "title": "Pengajuan Buku",
      "icon": "assets/submission.png",
      "route": "/pengajuan-buku"
    },
    {
      "title": "Paling Sering Ditanyakan",
      "icon": "assets/faq.png",
      "route": "/faq"
    }
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
