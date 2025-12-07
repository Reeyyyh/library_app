import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var books = <BookWithCategoryModel>[].obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs; // indikator loading
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void fetchBooks() {
    isLoading.value = true; // mulai loading

    supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .listen((List<Map<String, dynamic>> data) async {
      List<BookWithCategoryModel> result = [];
      for (var e in data) {
        final book = BookModel.fromMap(e);
        final catData = await supabase
            .from('categories')
            .select()
            .eq('id', book.kategoriId)
            .maybeSingle();
        if (catData != null) {
          final category = CategoryModel.fromMap(catData);
          result.add(BookWithCategoryModel(book: book, category: category));
        }
      }

      books.value = result;
      isLoading.value = false; // selesai loading
    });
  }

  List<BookWithCategoryModel> get filteredBooks {
    if (searchQuery.isEmpty) return books;
    final query = searchQuery.value.toLowerCase();
    return books
        .where((bookData) => bookData.book.judul.toLowerCase().contains(query))
        .toList();
  }

  void clearSearch() {
    searchQuery.value = '';
    searchController.clear();
  }
}
