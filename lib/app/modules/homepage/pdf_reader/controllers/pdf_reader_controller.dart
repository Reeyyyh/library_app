import 'package:get/get.dart';

class PdfReaderController extends GetxController {
  RxString pdfPath = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    pdfPath.value = arguments;
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
