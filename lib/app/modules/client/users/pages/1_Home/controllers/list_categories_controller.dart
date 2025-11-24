import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Controller untuk mengambil dan menampilkan semua kategori buku.
class ListCategoriesController extends GetxController {
  
  // Menyimpan daftar kategori yang diambil dari Firestore.
  var categories = <Map<String, dynamic>>[].obs;

  // Status loading saat mengambil data kategori.
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }
  // Mengambil semua kategori dari Firestore (urutan berdasarkan posisi).
  void fetchCategories() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('position')
          .get();

      categories.value =
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
