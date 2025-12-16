import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/models/book_model.dart';

class CreatebookController extends GetxController {
  // Controller untuk input form buku
  final judulC = TextEditingController();
  final penulisC = TextEditingController();
  final penerbitC = TextEditingController();
  final tahunC = TextEditingController();
  final stokC = TextEditingController();
  final deskripsiC = TextEditingController();

  // Data kategori dari Firestore
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  // File gambar buku (opsional)
  Rx<File?> imageFile = Rx<File?>(null);

  // Status buku (tersedia / dipinjam)
  Rx<BookStatus> status = BookStatus.tersedia.obs;

  // State loading untuk tombol simpan
  RxBool isLoading = false.obs;

  // Pesan error validasi form
  var judulError = ''.obs;
  var penulisError = ''.obs;
  var penerbitError = ''.obs;
  var tahunError = ''.obs;
  var stokError = ''.obs;
  var kategoriError = ''.obs;
  var deskripsiError = ''.obs;

  // Indikator validasi sukses tiap field
  var judulSuccess = false.obs;
  var penulisSuccess = false.obs;
  var penerbitSuccess = false.obs;
  var tahunSuccess = false.obs;
  var stokSuccess = false.obs;
  var kategoriSuccess = false.obs;
  var deskripsiSuccess = false.obs;

  // Membersihkan TextEditingController saat controller dihapus
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
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) imageFile.value = File(picked.path);
  }

  // Validasi seluruh input form
  bool validate() {
    bool isValid = true;

    // Reset pesan error & status sukses
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

    return isValid;
  }

  // Menyimpan data buku baru ke Firestore
  Future<void> createBook() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      final newBook = BookModel(
        id: "",
        judul: judulC.text,
        penulis: penulisC.text,
        penerbit: penerbitC.text,
        tahun: tahunC.text,
        stok: int.parse(stokC.text),
        status: status.value,
        kategori: selectedCategory.value,
        deskripsi: deskripsiC.text,
        image: imageFile.value?.path ?? '',
        createdAt: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('books')
          .add(newBook.toJson());

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Buku berhasil ditambahkan",
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFD32F2F),
        colorText: const Color(0xFFFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
