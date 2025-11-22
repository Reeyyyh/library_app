import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/admin/book_model.dart';

class UpdatebookController extends GetxController {
  // Text Controllers
  late TextEditingController judulC;
  late TextEditingController penulisC;
  late TextEditingController penerbitC;
  late TextEditingController tahunC;
  late TextEditingController stokC;
  late TextEditingController deskripsiC;

  Rx<BookStatus> status = BookStatus.tersedia.obs;


  // Kategori
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  // Error Messages
  var judulError = ''.obs;
  var penulisError = ''.obs;
  var penerbitError = ''.obs;
  var tahunError = ''.obs;
  var stokError = ''.obs;
  var kategoriError = ''.obs;
  var deskripsiError = ''.obs;

  // Success Flags (untuk border hijau)
  var judulSuccess = false.obs;
  var penulisSuccess = false.obs;
  var penerbitSuccess = false.obs;
  var tahunSuccess = false.obs;
  var stokSuccess = false.obs;
  var kategoriSuccess = false.obs;
  var deskripsiSuccess = false.obs;

  late String bookId;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onClose() {
    judulC.dispose();
    penulisC.dispose();
    penerbitC.dispose();
    tahunC.dispose();
    stokC.dispose();
    deskripsiC.dispose();
    super.onClose();
  }

  // Fetch categories
  void fetchCategories() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.value =
        snapshot.docs.map((doc) => doc['name'] as String).toList();
  }

  // Load book data
  void loadBook(BookModel book) {
    bookId = book.id;
    judulC = TextEditingController(text: book.judul);
    penulisC = TextEditingController(text: book.penulis);
    penerbitC = TextEditingController(text: book.penerbit);
    tahunC = TextEditingController(text: book.tahun);
    stokC = TextEditingController(text: book.stok.toString());
    deskripsiC = TextEditingController(text: book.deskripsi);
    selectedCategory.value = book.kategori;
    status.value = book.status;
  }

  // Validasi field
  bool validate() {
    bool isValid = true;

    // reset error & success
    judulError.value = '';
    penulisError.value = '';
    penerbitError.value = '';
    tahunError.value = '';
    stokError.value = '';
    kategoriError.value = '';
    deskripsiError.value = '';

    judulSuccess.value = false;
    penulisSuccess.value = false;
    penerbitSuccess.value = false;
    tahunSuccess.value = false;
    stokSuccess.value = false;
    kategoriSuccess.value = false;
    deskripsiSuccess.value = false;

    // Judul
    if (judulC.text.trim().isEmpty) {
      judulError.value = 'Judul wajib diisi';
      isValid = false;
    } else {
      judulSuccess.value = true;
    }

    // Penulis
    if (penulisC.text.trim().isEmpty) {
      penulisError.value = 'Penulis wajib diisi';
      isValid = false;
    } else {
      penulisSuccess.value = true;
    }

    // Penerbit
    if (penerbitC.text.trim().isEmpty) {
      penerbitError.value = 'Penerbit wajib diisi';
      isValid = false;
    } else {
      penerbitSuccess.value = true;
    }

    // Tahun
    if (tahunC.text.trim().isEmpty) {
      tahunError.value = 'Tahun wajib diisi';
      isValid = false;
    } else {
      tahunSuccess.value = true;
    }

    // Stok
    int stokValue = int.tryParse(stokC.text) ?? -1;
    if (stokC.text.trim().isEmpty) {
      stokError.value = 'Stok wajib diisi';
      isValid = false;
    } else if (stokValue < 0) {
      stokError.value = 'Stok harus angka';
      isValid = false;
    } else {
      stokSuccess.value = true;
    }

    // Kategori
    if (selectedCategory.value.isEmpty) {
      kategoriError.value = 'Kategori wajib dipilih';
      isValid = false;
    } else {
      kategoriSuccess.value = true;
    }

    // Deskripsi
    if (deskripsiC.text.trim().isEmpty) {
      deskripsiError.value = 'Deskripsi wajib diisi';
      isValid = false;
    } else {
      deskripsiSuccess.value = true;
    }

    return isValid;
  }

  // Update book
  Future<void> updateBook() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      await FirebaseFirestore.instance.collection('books').doc(bookId).update({
        'judul': judulC.text,
        'penulis': penulisC.text,
        'penerbit': penerbitC.text,
        'tahun': tahunC.text,
        'stok': int.tryParse(stokC.text) ?? 0,
        'kategori': selectedCategory.value,
        'deskripsi': deskripsiC.text,
        'status': status.value.toValue(),
        'updatedAt': Timestamp.now(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Buku berhasil diperbarui",
          backgroundColor: const Color(0xFF4CAF50), colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
