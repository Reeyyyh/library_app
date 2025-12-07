import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_app/app/models/category_model.dart';

class ListCategoriesController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  // Menyimpan daftar kategori
  var categories = <CategoryModel>[].obs;

  // Status loading saat mengambil data kategori
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

      final data = await supabase
          .from('categories')
          .select()
          .order('position', ascending: true);

      categories.value =
          (data as List<dynamic>).map((e) => CategoryModel.fromMap(e)).toList();
        } catch (e) {
      errorMessage.value = 'Gagal memuat kategori: $e';
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
