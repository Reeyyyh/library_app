import 'package:get/get.dart';

class BookDetailController extends GetxController {
  var data = {}.obs;
  var category = {}.obs;

  final count = 0.obs;
  @override
  void onInit() {
    var arguments = Get.arguments;
    super.onInit();
    data.value = arguments['data'];
    category.value = arguments['category'];
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
