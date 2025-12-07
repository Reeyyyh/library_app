import 'package:get/get.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListCategoryController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Getter: top 4
  List<CategoryModel> get top4 =>
      categories.length > 4 ? categories.sublist(0, 4) : categories;

  // Getter: other
  List<CategoryModel> get otherCategories =>
      categories.length > 4 ? categories.sublist(4) : [];

  // ==============================
  // GET CATEGORY
  // ==============================
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final res = await supabase
          .from('categories')
          .select()
          .order('position', ascending: true);

      categories.value = res.map((e) => CategoryModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // CREATE
  // ==============================
  Future<void> addCategory(String name) async {
    try {
      isLoading.value = true;

      // Ambil posisi terakhir
      final last = await supabase
          .from('categories')
          .select('position')
          .order('position', ascending: false)
          .limit(1);

      int newPosition = last.isNotEmpty ? (last.first['position'] ?? 0) + 1 : 0;

      await supabase.from('categories').insert({
        'name': name,
        'position': newPosition,
        'created_at': DateTime.now().toIso8601String(),
      });

      fetchCategories();
    } catch (e) {
      Get.snackbar("Error", "Gagal menambah kategori: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // UPDATE
  // ==============================
  Future<void> updateCategory(String id, String newName) async {
    try {
      isLoading.value = true;

      await supabase.from('categories').update({
        'name': newName,
      }).eq('id', id);

      fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Gagal update kategori: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // DELETE
  // ==============================
  Future<void> deleteCategory(String id) async {
    try {
      isLoading.value = true;

      await supabase.from('categories').delete().eq('id', id);

      await fetchCategories();
      await saveOrder();
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus kategori: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // REORDER
  // ==============================
  void reorderAll(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;

    final item = categories.removeAt(oldIndex);
    categories.insert(newIndex, item);

    await saveOrder();
  }

  // Simpan posisi baru
  Future<void> saveOrder() async {
    for (int i = 0; i < categories.length; i++) {
      await supabase.from('categories').update({
        'position': i,
      }).eq('id', categories[i].id);
    }
  }
}
