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

  void increment() => count.value++;
}
