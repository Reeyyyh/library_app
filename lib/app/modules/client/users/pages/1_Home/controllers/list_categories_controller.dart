import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListCategoriesController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // -------------------------------------------------------------------
  // FETCH (GET SEKALI)
  // -------------------------------------------------------------------
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('position')
          .get();

      categories.value = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      errorMessage.value = "Gagal memuat kategori: $e";
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // -------------------------------------------------------------------
  // STREAM (REAL-TIME)
  // -------------------------------------------------------------------
  Stream<List<Map<String, dynamic>>> categoryStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .orderBy('position')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // -------------------------------------------------------------------
  // REFRESH (Untuk pull-to-refresh)
  // -------------------------------------------------------------------
  Future<void> refreshCategories() async {
    await fetchCategories();
  }

  // -------------------------------------------------------------------
  // SEARCH CATEGORY BY NAME
  // -------------------------------------------------------------------
  Stream<List<Map<String, dynamic>>> searchCategory(String keyword) {
    if (keyword.trim().isEmpty) {
      return categoryStream(); // default full list
    }

    return FirebaseFirestore.instance
        .collection('categories')
        .where('name', isGreaterThanOrEqualTo: keyword)
        .where('name', isLessThanOrEqualTo: "$keyword\uf8ff")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }
}
