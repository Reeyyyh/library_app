import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('position')
          .limit(4)
          .get();

      categories.value = snapshot.docs
          .map((e) => {
                'id': e.id,
                ...e.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot> getLatestBooks() {
    return FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getTopCategoriesStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .orderBy('position')
        .limit(4)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                ...doc.data(),
              };
            }).toList());
  }

  Future<List<Map<String, dynamic>>> fetchLatestBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .get();

    return snapshot.docs.map((e) {
      return {
        'id': e.id,
        ...e.data() as Map<String, dynamic>,
      };
    }).toList();
  }
}
