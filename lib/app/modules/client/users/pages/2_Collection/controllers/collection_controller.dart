import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:library_app/app/modules/client/users/botnav/controllers/user_botnav_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  final botNavController = Get.find<UserBotNavController>();

  var books = <BookWithCategoryModel>[].obs;
  var allBooks = <BookWithCategoryModel>[].obs;

  var searchQuery = ''.obs;
  var isLoading = true.obs;

  final searchController = TextEditingController();

  CategoryModel? selectedCategory;
  String get selectedCategoryName =>
      botNavController.selectedCategory.value?.name ?? 'Semua';

  @override
  void onInit() {
    super.onInit();
    fetchBooks();

    ever(botNavController.selectedCategory, (_) {
      applyCategoryFilter();
    });
  }

  void applyCategoryFilter() {
    final selected = botNavController.selectedCategory.value;
    debugPrint('FILTER CATEGORY: ${selected?.name}');

    if (selected == null) {
      books.value = allBooks;
    } else {
      books.value =
          allBooks.where((e) => e.book.kategoriId == selected.id).toList();
    }
  }

  // void fetchBooks() {
  //   isLoading.value = true;

  //   supabase
  //       .from('books')
  //       .stream(primaryKey: ['id'])
  //       .order('created_at', ascending: false)
  //       .listen((List<Map<String, dynamic>> data) async {
  //         List<BookWithCategoryModel> result = [];

  //         for (final e in data) {
  //           final book = BookModel.fromMap(e);

  //           if (botNavController.selectedCategory.value != null &&
  //               book.kategoriId !=
  //                   botNavController.selectedCategory.value!.id) {
  //             continue;
  //           }

  //           final catData = await supabase
  //               .from('categories')
  //               .select()
  //               .eq('id', book.kategoriId)
  //               .maybeSingle();

  //           if (catData == null) continue;

  //           final category = CategoryModel.fromMap(catData);

  //           result.add(
  //             BookWithCategoryModel(
  //               book: book,
  //               category: category,
  //             ),
  //           );
  //         }

  //         books.value = result;
  //         isLoading.value = false;
  //       });
  // }

  void fetchBooks() {
    isLoading.value = true;

    supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .listen((List<Map<String, dynamic>> data) async {
          List<BookWithCategoryModel> result = [];

          for (final e in data) {
            final book = BookModel.fromMap(e);

            final catData = await supabase
                .from('categories')
                .select()
                .eq('id', book.kategoriId)
                .maybeSingle();

            if (catData == null) continue;

            final category = CategoryModel.fromMap(catData);

            result.add(
              BookWithCategoryModel(
                book: book,
                category: category,
              ),
            );
          }

          allBooks.value = result;
          applyCategoryFilter();
          isLoading.value = false;
        });
  }

  List<BookWithCategoryModel> get filteredBooks {
    if (searchQuery.value.isEmpty) return books;

    final query = searchQuery.value.toLowerCase();
    return books
        .where(
          (e) => e.book.judul.toLowerCase().contains(query),
        )
        .toList();
  }

  void clearSearch() {
    searchQuery.value = '';
    searchController.clear();
  }
}
