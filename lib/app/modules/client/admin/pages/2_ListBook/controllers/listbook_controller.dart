import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListBookController extends GetxController {
<<<<<<< HEAD
  final supabase = Supabase.instance.client;

  RxList<BookModel> books = <BookModel>[].obs;

=======
  // Mengambil stream daftar buku dari Firestore
  // Data diurutkan berdasarkan waktu pembuatan terbaru
>>>>>>> Srellica
  Stream<List<BookModel>> getBooks() {
    return supabase
        .from('books')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((list) => list.map((e) => BookModel.fromMap(e)).toList());
  }

<<<<<<< HEAD
=======
  // Menghapus data buku berdasarkan ID
>>>>>>> Srellica
  Future<void> deleteBook(String id) async {
    final bookData =
        await supabase.from('books').select('image').eq('id', id).maybeSingle();

    if (bookData != null && bookData['image'] != null) {
      final imageUrl = bookData['image'] as String;

      final fileName = imageUrl.split('/').last;

      await supabase.storage.from('book_images').remove([fileName]);
    }

    await supabase.from('books').delete().eq('id', id);
  }
}
