import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListCategoryController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // RxList untuk menyimpan data category
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  // Loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Ambil semua category
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final snapshot = await firestore.collection('categories').get();
      categories.value = snapshot.docs
          .map((doc) => {'id': doc.id, 'name': doc['name']})
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Tambah category baru
  Future<void> addCategory(String name) async {
    try {
      isLoading.value = true;
      await firestore.collection('categories').add({
        'name': name,
        'created_at': FieldValue.serverTimestamp(),
      });
      fetchCategories(); // refresh data
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Edit category
  Future<void> updateCategory(String id, String newName) async {
    try {
      isLoading.value = true;
      await firestore.collection('categories').doc(id).update({
        'name': newName,
      });
      fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengubah category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Hapus category
  Future<void> deleteCategory(String id) async {
    try {
      isLoading.value = true;
      await firestore.collection('categories').doc(id).delete();
      fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus category: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
