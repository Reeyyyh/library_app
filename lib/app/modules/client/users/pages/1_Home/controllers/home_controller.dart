import 'package:get/get.dart';
import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var categories = <CategoryModel>[].obs;
  var latestBooks = <BookWithCategoryModel>[].obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  // GET CATEGORIES
  // REAL-TIME CATEGORY STREAM
  Stream<List<CategoryModel>> categoriesStream() {
    return supabase
        .from('categories')
        .stream(primaryKey: ['id'])
        .order('position', ascending: true)
        .limit(4)
        .map((event) => event.map((e) => CategoryModel.fromMap(e)).toList());
  }

  // REAL-TIME LATEST BOOK STREAM
  Stream<List<BookWithCategoryModel>> latestBooksStream() {
    return supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(2)
        .asyncMap((event) async {
          List<BookWithCategoryModel> result = [];

          for (var e in event) {
            final book = BookModel.fromMap(e);

            // Ambil kategori
            final catData = await supabase
                .from('categories')
                .select()
                .eq('id', book.kategoriId)
                .maybeSingle();

            // === FIX DI SINI ===
            final category = (catData != null)
                ? CategoryModel.fromMap(catData)
                : CategoryModel(
                    id: '',
                    name: 'Tidak ada kategori',
                    position: 0,
                  );

            result.add(BookWithCategoryModel(book: book, category: category));
          }

          return result;
        });
  }

  // SEARCH BOOKS

  Stream<List<BookModel>> searchBooks(String keyword) {
    return supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((event) => event
            .map((e) => BookModel.fromMap(e))
            .where((book) =>
                book.judul.toLowerCase().contains(keyword.toLowerCase()))
            .toList());
  }

  // FILTER BOOKS BY CATEGORY
  Stream<List<BookModel>> getBooksByCategory(String categoryId) {
    return supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((event) => event
            .map((e) => BookModel.fromMap(e))
            .where((book) => book.kategoriId == categoryId)
            .toList());
  }
}
