import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
    loadInitialBooks();
  }

  // ---------------------------------------------------------------------------
  // GET CATEGORIES
  // ---------------------------------------------------------------------------
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
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // ---------------------------------------------------------------------------
  // FETCH LATEST BOOKS (MANUAL FETCH)
  // ---------------------------------------------------------------------------
  Future<void> loadInitialBooks() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('books')
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      latestBooks.value = snapshot.docs.map((e) {
        return {
          'id': e.id,
          ...e.data() as Map<String, dynamic>,
        };
      }).toList();

      if (snapshot.docs.isNotEmpty) {
        lastBookDocument = snapshot.docs.last;
      }
    } catch (e) {
      errorMessage.value = "Gagal memuat buku terbaru: $e";
    }
  }

  // ---------------------------------------------------------------------------
  // LOAD MORE BOOKS (PAGINATION)
  // ---------------------------------------------------------------------------
  Future<void> loadMoreBooks() async {
    if (lastBookDocument == null) return;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('books')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(lastBookDocument!)
          .limit(5)
          .get();

      if (snapshot.docs.isNotEmpty) {
        lastBookDocument = snapshot.docs.last;

        latestBooks.addAll(snapshot.docs.map((e) {
          return {
            'id': e.id,
            ...e.data() as Map<String, dynamic>,
          };
        }));
      }
    } catch (e) {
      errorMessage.value = "Gagal memuat lebih banyak buku: $e";
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
          ...e.data() as Map<String, dynamic>,
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
          ...e.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // ---------------------------------------------------------------------------
  // REFRESH ALL (BUAT PULL TO REFRESH)
  // ---------------------------------------------------------------------------
  Future<void> refreshHome() async {
    await getCategories();
    await loadInitialBooks();
  }
}
