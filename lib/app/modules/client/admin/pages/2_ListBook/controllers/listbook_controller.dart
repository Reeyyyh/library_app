import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';

class ListBookController extends GetxController {
  // Mengambil stream daftar buku dari Firestore
  // Data diurutkan berdasarkan waktu pembuatan terbaru
  Stream<List<BookModel>> getBooks() {
    return FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => BookModel.fromDoc(doc))
          .toList();
    });
  }

  // Menghapus data buku berdasarkan ID
  Future<void> deleteBook(String id) async {
    await FirebaseFirestore.instance.collection('books').doc(id).delete();
  }
}
