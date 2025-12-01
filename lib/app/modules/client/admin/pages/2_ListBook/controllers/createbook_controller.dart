import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/models/book_model.dart';

class CreatebookController extends GetxController {
  // Text Controllers
  // data wajib
  final judulC = TextEditingController();
  final penulisC = TextEditingController();
  final penerbitC = TextEditingController();
  final tahunC = TextEditingController();
  final stokC = TextEditingController();
  final deskripsiC = TextEditingController();
  // opsional
  final isbnC = TextEditingController();
  final jumlahHalamanC = TextEditingController();
  final bahasaC = TextEditingController();
  final lokasiRakC = TextEditingController();

  // Categories (real-time)
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

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

<<<<<<< HEAD
=======
  // Success indicator
>>>>>>> origin/rakarajinibadah
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
    listenCategories();
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


  void listenCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .orderBy('position')
        .snapshots()
        .listen((snapshot) {
      categories.value =
          snapshot.docs.map((doc) => doc['name'] as String).toList();

      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first;
      }
    });
  }

 
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) imageFile.value = File(picked.path);
  }

 
  bool validate() {
    bool isValid = true;

    // Reset previous errors
    judulError.value = '';
    penulisError.value = '';
    penerbitError.value = '';
    tahunError.value = '';
    stokError.value = '';
    kategoriError.value = '';
    deskripsiError.value = '';

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

    // Tahun (validasi 4 digit)
    if (!RegExp(r'^\d{4}$').hasMatch(tahunC.text)) {
      tahunError.value = 'Tahun harus 4 digit angka';
      isValid = false;
    } else {
      tahunSuccess.value = true;
    }

    // Stok
    int stokValue = int.tryParse(stokC.text) ?? -1;
    if (stokValue < 1) {
      stokError.value = 'Stok harus angka dan minimal 1';
      isValid = false;
    } else {
      stokSuccess.value = true;
    }

    // Status otomatis berdasarkan stok
    status.value = stokValue == 0 ? BookStatus.tidakTersedia : BookStatus.tersedia;

    // Kategori
    if (selectedCategory.value.isEmpty) {
      kategoriError.value = 'Kategori wajib dipilih';
      isValid = false;
    } else {
      kategoriSuccess.value = true;
    }

    // Deskripsi minimal 10 karakter
    if (deskripsiC.text.trim().length < 10) {
      deskripsiError.value = 'Deskripsi minimal 10 karakter';
      isValid = false;
    } else {
      deskripsiSuccess.value = true;
    }

    return isValid;
  }

  Future<String> uploadImage(File file) async {
    String fileName = "books/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final ref = FirebaseStorage.instance.ref().child(fileName);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  
  Future<void> createBook() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      // Upload image first
      String imageUrl = "";
      if (imageFile.value != null) {
        imageUrl = await uploadImage(imageFile.value!);
      }

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
        image: imageUrl,
        createdAt: Timestamp.now(),
        // opsional
        isbn: isbnC.text.isEmpty ? null : isbnC.text,
        jumlahHalaman: jumlahHalamanC.text.isEmpty
            ? null
            : int.tryParse(jumlahHalamanC.text),
        bahasa: bahasaC.text.isEmpty ? null : bahasaC.text,
        lokasiRak: lokasiRakC.text.isEmpty ? null : lokasiRakC.text,
      );

      await FirebaseFirestore.instance
          .collection('books')
          .add(newBook.toJson());

      resetForm();

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Buku berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Firebase Error",
        e.message ?? e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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

 
  void resetForm() {
    judulC.clear();
    penulisC.clear();
    penerbitC.clear();
    tahunC.clear();
    stokC.clear();
    deskripsiC.clear();
    imageFile.value = null;

    selectedCategory.value =
        categories.isNotEmpty ? categories.first : '';

    judulSuccess.value = false;
    penulisSuccess.value = false;
    penerbitSuccess.value = false;
    tahunSuccess.value = false;
    stokSuccess.value = false;
    kategoriSuccess.value = false;
    deskripsiSuccess.value = false;
  }
}
