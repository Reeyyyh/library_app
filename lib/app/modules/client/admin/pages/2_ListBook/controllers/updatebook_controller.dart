import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatebookController extends GetxController {
  final supabase = Supabase.instance.client;

  // Text Controllers
  late TextEditingController judulC;
  late TextEditingController penulisC;
  late TextEditingController penerbitC;
  late TextEditingController tahunC;
  late TextEditingController stokC;
  late TextEditingController deskripsiC;

  late TextEditingController isbnC;
  late TextEditingController jumlahHalamanC;
  late TextEditingController bahasaC;
  late TextEditingController lokasiRakC;

  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // Categories
  var categories = <CategoryModel>[].obs;
  var selectedCategoryId = ''.obs;

  // Error flags
  var judulError = ''.obs;
  var penulisError = ''.obs;
  var penerbitError = ''.obs;
  var tahunError = ''.obs;
  var stokError = ''.obs;
  var kategoriError = ''.obs;
  var deskripsiError = ''.obs;

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
    isbnC.dispose();
    jumlahHalamanC.dispose();
    bahasaC.dispose();
    lokasiRakC.dispose();
    super.onClose();
  }

  // ============================================================
  // FETCH CATEGORIES
  // ============================================================
  Future<void> fetchCategories() async {
    final res = await supabase.from('categories').select('*');

    categories.value =
        res.map<CategoryModel>((map) => CategoryModel.fromMap(map)).toList();
  }

  // ============================================================
  // LOAD BOOK
  // ============================================================
  void loadBook(BookModel book) {
    bookId = book.id;

    judulC = TextEditingController(text: book.judul);
    penulisC = TextEditingController(text: book.penulis);
    penerbitC = TextEditingController(text: book.penerbit);
    tahunC = TextEditingController(text: book.tahun);
    stokC = TextEditingController(text: book.stok.toString());
    deskripsiC = TextEditingController(text: book.deskripsi);

    isbnC = TextEditingController(text: book.isbn ?? '');
    jumlahHalamanC =
        TextEditingController(text: book.jumlahHalaman?.toString() ?? '');
    bahasaC = TextEditingController(text: book.bahasa ?? '');
    lokasiRakC = TextEditingController(text: book.lokasiRak ?? '');

    selectedCategoryId.value = book.kategoriId;
    status.value = book.status;
  }

  // ============================================================
  // VALIDATION (tidak berubah)
  // ============================================================
  bool validate() {
    bool isValid = true;

    judulError.value = '';
    penulisError.value = '';
    penerbitError.value = '';
    tahunError.value = '';
    stokError.value = '';
    kategoriError.value = '';
    deskripsiError.value = '';

    judulSuccess.value = judulC.text.isNotEmpty;
    if (!judulSuccess.value) { judulError.value = 'Judul wajib diisi'; isValid = false; }

    penulisSuccess.value = penulisC.text.isNotEmpty;
    if (!penulisSuccess.value) { penulisError.value = 'Penulis wajib diisi'; isValid = false; }

    penerbitSuccess.value = penerbitC.text.isNotEmpty;
    if (!penerbitSuccess.value) { penerbitError.value = 'Penerbit wajib diisi'; isValid = false; }

    tahunSuccess.value = tahunC.text.isNotEmpty;
    if (!tahunSuccess.value) { tahunError.value = 'Tahun wajib diisi'; isValid = false; }

    int stokValue = int.tryParse(stokC.text) ?? -1;
    stokSuccess.value = stokValue >= 0;
    if (!stokSuccess.value) { stokError.value = 'Stok harus angka'; isValid = false; }

    kategoriSuccess.value = selectedCategoryId.value.isNotEmpty;
    if (!kategoriSuccess.value) { kategoriError.value = 'Kategori wajib dipilih'; isValid = false; }

    deskripsiSuccess.value = deskripsiC.text.isNotEmpty;
    if (!deskripsiSuccess.value) { deskripsiError.value = 'Deskripsi wajib diisi'; isValid = false; }

    return isValid;
  }

  // ============================================================
  // UPDATE BOOK (final fix)
  // ============================================================
  Future<void> updateBook() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      await supabase.from('books').update({
        'judul': judulC.text,
        'penulis': penulisC.text,
        'penerbit': penerbitC.text,
        'tahun': tahunC.text,
        'stok': int.parse(stokC.text),
        'kategori_id': selectedCategoryId.value,
        'deskripsi': deskripsiC.text,
        'status': status.value.toValue(),
        'isbn': isbnC.text.isEmpty ? null : isbnC.text,
        'jumlah_halaman':
            jumlahHalamanC.text.isEmpty ? null : int.tryParse(jumlahHalamanC.text),
        'bahasa': bahasaC.text.isEmpty ? null : bahasaC.text,
        'lokasi_rak': lokasiRakC.text.isEmpty ? null : lokasiRakC.text,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', bookId);

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
