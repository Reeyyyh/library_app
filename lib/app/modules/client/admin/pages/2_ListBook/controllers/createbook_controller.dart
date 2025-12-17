import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatebookController extends GetxController {
<<<<<<< HEAD
  final supabase = Supabase.instance.client;

  // Text Controllers
=======
  // Controller untuk input form buku
>>>>>>> Srellica
  final judulC = TextEditingController();
  final penulisC = TextEditingController();
  final penerbitC = TextEditingController();
  final tahunC = TextEditingController();
  final stokC = TextEditingController();
  final deskripsiC = TextEditingController();
  final isbnC = TextEditingController();
  final jumlahHalamanC = TextEditingController();
  final bahasaC = TextEditingController();
  final lokasiRakC = TextEditingController();

<<<<<<< HEAD
  // Kategori
  var categories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  var selectedCategoryId = ''.obs;

  // Image
=======
  // Data kategori dari Firestore
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  // File gambar buku (opsional)
>>>>>>> Srellica
  Rx<File?> imageFile = Rx<File?>(null);

  // Status buku (tersedia / dipinjam)
  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // State loading untuk tombol simpan
  RxBool isLoading = false.obs;

<<<<<<< HEAD
  // Error messages
=======
  // Pesan error validasi form
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
  // Indikator validasi sukses tiap field
>>>>>>> Srellica
  var judulSuccess = false.obs;
  var penulisSuccess = false.obs;
  var penerbitSuccess = false.obs;
  var tahunSuccess = false.obs;
  var stokSuccess = false.obs;
  var kategoriSuccess = false.obs;
  var deskripsiSuccess = false.obs;

  // Membersihkan TextEditingController saat controller dihapus
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

<<<<<<< HEAD
  // =====================================================================
  // FETCH CATEGORIES FROM SUPABASE
  // =====================================================================
  Future<void> fetchCategories() async {
    final res = await supabase.from('categories').select('*');

    categories.value = res.map<CategoryModel>((map) {
      return CategoryModel.fromMap(map);
    }).toList();

    if (categories.isNotEmpty) {
      selectedCategory.value = categories.first;
      selectedCategoryId.value = categories.first.id;
    }
  }

  // =====================================================================
  // PICK IMAGE
  // =====================================================================
=======
  // Mengambil data kategori saat halaman dibuka
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch daftar kategori dari Firestore
  void fetchCategories() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.value =
        snapshot.docs.map((doc) => doc['name'] as String).toList();
    if (categories.isNotEmpty) selectedCategory.value = categories.first;
  }

  // Mengambil gambar dari galeri
>>>>>>> Srellica
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

<<<<<<< HEAD
  // =====================================================================
  // VALIDATION
  // =====================================================================
  bool validate() {
    bool isValid = true;

    // reset errors
=======
  // Validasi seluruh input form
  bool validate() {
    bool isValid = true;

    // Reset pesan error & status sukses
>>>>>>> Srellica
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

<<<<<<< HEAD
=======
    // Validasi judul
>>>>>>> Srellica
    if (judulC.text.trim().isEmpty) {
      judulError.value = "Judul wajib diisi";
      isValid = false;
    } else {
      judulSuccess.value = true;
    }

<<<<<<< HEAD
=======
    // Validasi penulis
>>>>>>> Srellica
    if (penulisC.text.trim().isEmpty) {
      penulisError.value = "Penulis wajib diisi";
      isValid = false;
    } else {
      penulisSuccess.value = true;
    }

<<<<<<< HEAD
=======
    // Validasi penerbit
>>>>>>> Srellica
    if (penerbitC.text.trim().isEmpty) {
      penerbitError.value = "Penerbit wajib diisi";
      isValid = false;
    } else {
      penerbitSuccess.value = true;
    }

<<<<<<< HEAD
=======
    // Validasi tahun
>>>>>>> Srellica
    if (tahunC.text.trim().isEmpty) {
      tahunError.value = "Tahun wajib diisi";
      isValid = false;
    } else {
      tahunSuccess.value = true;
    }

<<<<<<< HEAD
=======
    // Validasi stok
>>>>>>> Srellica
    int stokValue = int.tryParse(stokC.text) ?? -1;
    if (stokC.text.trim().isEmpty) {
      stokError.value = "Stok wajib diisi";
      isValid = false;
    } else if (stokValue < 0) {
      stokError.value = "Stok harus angka";
      isValid = false;
    } else {
      stokSuccess.value = true;
    }

<<<<<<< HEAD
    if (selectedCategoryId.value.isEmpty) {
      kategoriError.value = "Kategori wajib dipilih";
=======
    // Validasi kategori
    if (selectedCategory.value.isEmpty) {
      kategoriError.value = 'Kategori wajib dipilih';
>>>>>>> Srellica
      isValid = false;
    } else {
      kategoriSuccess.value = true;
    }

<<<<<<< HEAD
=======
    // Validasi deskripsi
>>>>>>> Srellica
    if (deskripsiC.text.trim().isEmpty) {
      deskripsiError.value = "Deskripsi wajib diisi";
      isValid = false;
    } else {
      deskripsiSuccess.value = true;
    }

    return isValid;
  }

<<<<<<< HEAD
  // =====================================================================
  // UPLOAD IMAGE TO SUPABASE STORAGE
  // =====================================================================
  Future<String> uploadImage() async {
    if (imageFile.value == null) return '';

    final filename = 'book_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage
        .from('book_images')
        .upload(filename, imageFile.value!);

    final publicUrl =
        supabase.storage.from('book_images').getPublicUrl(filename);

    return publicUrl;
  }

  // =====================================================================
  // CREATE BOOK (SUPABASE)
  // =====================================================================
=======
  // Menyimpan data buku baru ke Firestore
>>>>>>> Srellica
  Future<void> createBook() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      // Upload image if any
      final imageUrl = await uploadImage();

      final newBook = BookModel(
        id: "",
        judul: judulC.text,
        penulis: penulisC.text,
        penerbit: penerbitC.text,
        tahun: tahunC.text,
        stok: int.parse(stokC.text),
        status: status.value,
        kategoriId: selectedCategoryId.value,
        deskripsi: deskripsiC.text,
        image: imageUrl,
        isbn: isbnC.text.isEmpty ? null : isbnC.text,
        jumlahHalaman: jumlahHalamanC.text.isEmpty
            ? null
            : int.tryParse(jumlahHalamanC.text),
        bahasa: bahasaC.text.isEmpty ? null : bahasaC.text,
        lokasiRak: lokasiRakC.text.isEmpty ? null : lokasiRakC.text,
      );

      await supabase.from('books').insert(newBook.toMap());

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Buku berhasil ditambahkan",
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFD32F2F),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
