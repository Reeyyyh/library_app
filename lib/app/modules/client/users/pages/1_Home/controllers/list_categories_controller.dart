import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Controller untuk mengambil dan menampilkan semua kategori buku.
class ListCategoriesController extends GetxController {
  // Menyimpan daftar kategori yang diambil dari Firestore.
  var categories = <Map<String, dynamic>>[].obs;

  // Status loading saat mengambil data kategori.
  var isLoading = true.obs;
  var errorMessage = "".obs;
// Inisialisasi controller dan memuat kategori saat controller dibuat
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // -------------------------------------------------------------------
  // FETCH (GET SEKALI)
  // -------------------------------------------------------------------
  Future<void> fetchCategories() async {
    // Mengambil semua kategori dari Firestore Database (urutan berdasarkan posisi).

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
}
