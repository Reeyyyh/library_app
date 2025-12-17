import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatebookController extends GetxController {
<<<<<<< HEAD
  final supabase = Supabase.instance.client;

  // Text Controllers
=======
  // TextEditingController untuk menampung input form edit buku
>>>>>>> Srellica
  late TextEditingController judulC;
  late TextEditingController penulisC;
  late TextEditingController penerbitC;
  late TextEditingController tahunC;
  late TextEditingController stokC;
  late TextEditingController deskripsiC;

<<<<<<< HEAD
  late TextEditingController isbnC;
  late TextEditingController jumlahHalamanC;
  late TextEditingController bahasaC;
  late TextEditingController lokasiRakC;

  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // Categories
  var categories = <CategoryModel>[].obs;
  var selectedCategoryId = ''.obs;

  // Error flags
=======
  // Status ketersediaan buku
  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // Daftar kategori dan kategori terpilih
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  // Pesan error validasi setiap field
>>>>>>> Srellica
  var judulError = ''.obs;
  var penulisError = ''.obs;
  var penerbitError = ''.obs;
  var tahunError = ''.obs;
  var stokError = ''.obs;
  var kategoriError = ''.obs;
  var deskripsiError = ''.obs;

<<<<<<< HEAD
=======
  // Flag sukses validasi (untuk tampilan border hijau)
>>>>>>> Srellica
  var judulSuccess = false.obs;
  var penulisSuccess = false.obs;
  var penerbitSuccess = false.obs;
  var tahunSuccess = false.obs;
  var stokSuccess = false.obs;
  var kategoriSuccess = false.obs;
  var deskripsiSuccess = false.obs;

  // ID buku yang sedang diedit
  late String bookId;

  // Status loading saat proses update
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onClose() {
    // Membersihkan controller untuk mencegah memory leak
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

<<<<<<< HEAD
  // ============================================================
  // FETCH CATEGORIES
  // ============================================================
  Future<void> fetchCategories() async {
    final res = await supabase.from('categories').select('*');

=======
  // Mengambil daftar kategori dari Firestore
  void fetchCategories() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
>>>>>>> Srellica
    categories.value =
        res.map<CategoryModel>((map) => CategoryModel.fromMap(map)).toList();
  }

<<<<<<< HEAD
  // ============================================================
  // LOAD BOOK
  // ============================================================
=======
  // Mengisi form dengan data buku yang akan diedit
>>>>>>> Srellica
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

<<<<<<< HEAD
  // ============================================================
  // VALIDATION (tidak berubah)
  // ============================================================
  bool validate() {
    bool isValid = true;

=======
  // Validasi seluruh field input sebelum update
  bool validate() {
    bool isValid = true;

    // Reset error dan status sukses
>>>>>>> Srellica
    judulError.value = '';
    penulisError.value = '';
    penerbitError.value = '';
    tahunError.value = '';
    stokError.value = '';
    kategoriError.value = '';
    deskripsiError.value = '';

    judulSuccess.value = judulC.text.isNotEmpty;
    if (!judulSuccess.value) { judulError.value = 'Judul wajib diisi'; isValid = false; }

<<<<<<< HEAD
    penulisSuccess.value = penulisC.text.isNotEmpty;
    if (!penulisSuccess.value) { penulisError.value = 'Penulis wajib diisi'; isValid = false; }

    penerbitSuccess.value = penerbitC.text.isNotEmpty;
    if (!penerbitSuccess.value) { penerbitError.value = 'Penerbit wajib diisi'; isValid = false; }

    tahunSuccess.value = tahunC.text.isNotEmpty;
    if (!tahunSuccess.value) { tahunError.value = 'Tahun wajib diisi'; isValid = false; }

=======
    // Validasi judul
    if (judulC.text.trim().isEmpty) {
      judulError.value = 'Judul wajib diisi';
      isValid = false;
    } else {
      judulSuccess.value = true;
    }

    // Validasi penulis
    if (penulisC.text.trim().isEmpty) {
      penulisError.value = 'Penulis wajib diisi';
      isValid = false;
    } else {
      penulisSuccess.value = true;
    }

    // Validasi penerbit
    if (penerbitC.text.trim().isEmpty) {
      penerbitError.value = 'Penerbit wajib diisi';
      isValid = false;
    } else {
      penerbitSuccess.value = true;
    }

    // Validasi tahun
    if (tahunC.text.trim().isEmpty) {
      tahunError.value = 'Tahun wajib diisi';
      isValid = false;
    } else {
      tahunSuccess.value = true;
    }

    // Validasi stok
>>>>>>> Srellica
    int stokValue = int.tryParse(stokC.text) ?? -1;
    stokSuccess.value = stokValue >= 0;
    if (!stokSuccess.value) { stokError.value = 'Stok harus angka'; isValid = false; }

<<<<<<< HEAD
    kategoriSuccess.value = selectedCategoryId.value.isNotEmpty;
    if (!kategoriSuccess.value) { kategoriError.value = 'Kategori wajib dipilih'; isValid = false; }

    deskripsiSuccess.value = deskripsiC.text.isNotEmpty;
    if (!deskripsiSuccess.value) { deskripsiError.value = 'Deskripsi wajib diisi'; isValid = false; }
=======
    // Validasi kategori
    if (selectedCategory.value.isEmpty) {
      kategoriError.value = 'Kategori wajib dipilih';
      isValid = false;
    } else {
      kategoriSuccess.value = true;
    }

    // Validasi deskripsi
    if (deskripsiC.text.trim().isEmpty) {
      deskripsiError.value = 'Deskripsi wajib diisi';
      isValid = false;
    } else {
      deskripsiSuccess.value = true;
    }
>>>>>>> Srellica

    return isValid;
  }

<<<<<<< HEAD
  // ============================================================
  // UPDATE BOOK (final fix)
  // ============================================================
=======
  // Memperbarui data buku ke Firestore
>>>>>>> Srellica
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
<<<<<<< HEAD
      Get.snackbar("Berhasil", "Buku berhasil diperbarui",
          backgroundColor: const Color(0xFF4CAF50), colorText: Colors.white);

=======
      Get.snackbar(
        "Berhasil",
        "Buku berhasil diperbarui",
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
      );
>>>>>>> Srellica
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
