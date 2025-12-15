import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatebookController extends GetxController {
  final supabase = Supabase.instance.client;

  // Text Controllers
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

  // Kategori
  var categories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  var selectedCategoryId = ''.obs;

  // Image
  Rx<File?> imageFile = Rx<File?>(null);

  // Status
  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // Loading State
  RxBool isLoading = false.obs;

  // Error messages
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
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  // =====================================================================
  // VALIDATION
  // =====================================================================
  bool validate() {
    bool isValid = true;

    // reset errors
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

    if (judulC.text.trim().isEmpty) {
      judulError.value = "Judul wajib diisi";
      isValid = false;
    } else {
      judulSuccess.value = true;
    }

    if (penulisC.text.trim().isEmpty) {
      penulisError.value = "Penulis wajib diisi";
      isValid = false;
    } else {
      penulisSuccess.value = true;
    }

    if (penerbitC.text.trim().isEmpty) {
      penerbitError.value = "Penerbit wajib diisi";
      isValid = false;
    } else {
      penerbitSuccess.value = true;
    }

    if (tahunC.text.trim().isEmpty) {
      tahunError.value = "Tahun wajib diisi";
      isValid = false;
    } else {
      tahunSuccess.value = true;
    }

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

    if (selectedCategoryId.value.isEmpty) {
      kategoriError.value = "Kategori wajib dipilih";
      isValid = false;
    } else {
      kategoriSuccess.value = true;
    }

    if (deskripsiC.text.trim().isEmpty) {
      deskripsiError.value = "Deskripsi wajib diisi";
      isValid = false;
    } else {
      deskripsiSuccess.value = true;
    }

    return isValid;
  }

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
