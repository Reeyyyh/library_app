import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListCategoryController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Getter: top 4 kategori
  List<Map<String, dynamic>> get top4 =>
      categories.length > 4 ? categories.sublist(0, 4) : categories;

  // Getter: kategori lain
  List<Map<String, dynamic>> get otherCategories =>
      categories.length > 4 ? categories.sublist(4) : [];

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final snapshot = await firestore
          .collection('categories')
          .orderBy('position', descending: false)
          .get();

      categories.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['name'],
          'position': data['position'],
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Tambah category
  Future<void> addCategory(String name) async {
    try {
      isLoading.value = true;

      final last = await firestore
          .collection('categories')
          .orderBy('position', descending: true)
          .limit(1)
          .get();

      int newPosition =
          last.docs.isNotEmpty ? last.docs.first['position'] + 1 : 0;

      await firestore.collection('categories').add({
        'name': name,
        'position': newPosition,
        'created_at': FieldValue.serverTimestamp(),
      });

      await fetchCategories();
    } catch (e) {
      Get.snackbar("Error", "Gagal menambah kategori: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Edit Category
  Future<void> updateCategory(String id, String newName) async {
    try {
      isLoading.value = true;

      await firestore.collection('categories').doc(id).update({
        'name': newName,
      });

      await fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengubah kategori: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete Category
  Future<void> deleteCategory(String id) async {
    try {
      isLoading.value = true;

      await firestore.collection('categories').doc(id).delete();
      await fetchCategories();
      await saveOrderToFirebase();
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus kategori: $e');
    } finally {
      isLoading.value = false;
    }
  }
  // Reorder Category
  void reorderAll(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;

    final item = categories.removeAt(oldIndex);
    categories.insert(newIndex, item);

    await saveOrderToFirebase();
  }// Simpan urutan category ke database Firebase
  Future<void> saveOrderToFirebase() async {
    for (int i = 0; i < categories.length; i++) {
      await firestore
          .collection("categories")
          .doc(categories[i]['id'])
          .update({'position': i});
    }
  }
}
