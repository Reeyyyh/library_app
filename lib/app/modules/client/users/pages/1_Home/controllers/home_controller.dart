import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Controller untuk halaman Home: kategori & buku terbaru.
class HomeController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  var latestBooks = <Map<String, dynamic>>[].obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  DocumentSnapshot? lastBookDocument;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  // ---------------------------------------------------------------------------
  // GET CATEGORIES
  // ---------------------------------------------------------------------------
  // Mengambil kategori dari Firestore (urutan berdasarkan posisi).
  Future<void> getCategories() async {
    try {
      isLoading.value = true;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('position')
          .limit(4)
          .get();

      categories.value = snapshot.docs.map((e) {
        return {
          'id': e.id,
          ...e.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      errorMessage.value = "Gagal memuat kategori: $e";
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // REAL-TIME TOP CATEGORIES
  // ---------------------------------------------------------------------------
  // Stream realtime untuk mendapatkan 2 buku terbaru.
  Stream<QuerySnapshot> getLatestBooks() {
    return FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .snapshots();
  }

  // Stream realtime untuk mendapatkan kategori teratas (4 kategori).
  Stream<List<Map<String, dynamic>>> getTopCategoriesStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .orderBy('position')
        .limit(4)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    });
  }

  // Mengambil 2 buku terbaru (tanpa stream).
  Future<List<Map<String, dynamic>>> fetchLatestBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .get();

    return snapshot.docs.map((e) {
      return {
        'id': e.id,
        ...e.data() as Map<String, dynamic>,
      };
    }).toList();
  }
}

// ---------------------------------------------------------------------------
// SEARCH BOOKS (REAL-TIME)
// ---------------------------------------------------------------------------
Stream<List<Map<String, dynamic>>> searchBooks(String keyword) {
  return FirebaseFirestore.instance
      .collection('books')
      .where('title', isGreaterThanOrEqualTo: keyword)
      .where('title', isLessThanOrEqualTo: "$keyword\uf8ff")
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) {
      return {
        'id': e.id,
        ...e.data(),
      };
    }).toList();
  });
}

// ---------------------------------------------------------------------------
// FILTER BOOKS BY CATEGORY
// ---------------------------------------------------------------------------
Stream<List<Map<String, dynamic>>> getBooksByCategory(String categoryId) {
  return FirebaseFirestore.instance
      .collection('books')
      .where('categoryId', isEqualTo: categoryId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) {
      return {
        'id': e.id,
        ...e.data(),
      };
    }).toList();
  });
}
