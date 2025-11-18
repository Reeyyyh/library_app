import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';
import 'package:library_app/app/services/cloudinary_services.dart';
import 'package:library_app/app/services/supabase_service.dart';
import 'package:library_app/app/widgets/generate_keywords.dart';

class UpdateBookController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  TextEditingController judulController = TextEditingController(
    text: 'Judul Buku',
  );
  TextEditingController penulisController = TextEditingController(
    text: 'Penulis Buku',
  );
  TextEditingController penerbitController = TextEditingController(
    text: 'Penerbit Buku',
  );
  TextEditingController tahunController = TextEditingController(
    text: '2021',
  );
  TextEditingController stokController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController(
    text: 'Deskripsi Buku',
  );
  TextEditingController digitalBookController = TextEditingController();
  RxString imageUrl = ''.obs;
  RxString dataDigitalBookUrl = ''.obs;

  RxString judulError = ''.obs;
  RxString penulisError = ''.obs;
  RxString penerbitError = ''.obs;
  RxString tahunError = ''.obs;
  RxString stokError = ''.obs;
  RxString statusError = ''.obs;
  RxString kategoriError = ''.obs;
  RxString deskripsiError = ''.obs;
  RxString digitalBookError = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  RxString imageError = ''.obs;
  RxBool isDigital = false.obs;
  RxString mediaPath = ''.obs;
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxBool statusController = false.obs;
  RxString digitalBookPath = ''.obs;
  RxString bookId = ''.obs;

  RxBool isErrorForm = false.obs;

  onSubmit() async {
    var categorySelected = categories
        .where((element) =>
            element['index'] == int.tryParse(kategoriController.text))
        .toList();
    if (judulController.text.isEmpty) {
      judulError.value = 'Judul tidak boleh kosong';
    } else {
      judulError.value = '';
    }
    if (penulisController.text.isEmpty) {
      penulisError.value = 'Penulis tidak boleh kosong';
    } else {
      penulisError.value = '';
    }
    if (penerbitController.text.isEmpty) {
      penerbitError.value = 'Penerbit tidak boleh kosong';
    } else {
      penerbitError.value = '';
    }
    if (tahunController.text.isEmpty) {
      tahunError.value = 'Tahun terbit tidak boleh kosong';
    } else {
      tahunError.value = '';
    }
    if (stokController.text.isEmpty) {
      stokError.value = 'Stok tidak boleh kosong';
    } else {
      stokError.value = '';
    }
    if (kategoriController.text.isEmpty) {
      kategoriError.value = 'Kategori tidak boleh kosong';
    } else {
      kategoriError.value = '';
    }
    if (deskripsiController.text.isEmpty) {
      deskripsiError.value = 'Deskripsi tidak boleh kosong';
    } else {
      deskripsiError.value = '';
    }
    if (isDigital.value == true) {
      if (digitalBookController.text.isEmpty) {
        digitalBookError.value = 'Digital Book tidak boleh kosong';
      } else {
        digitalBookError.value = '';
      }
    } else {
      if (stokController.text.isEmpty) {
        stokError.value = 'Stok tidak boleh kosong';
      } else {
        stokError.value = '';
      }
    }
    if (mediaPath.value.isEmpty) {
      imageError.value = 'Gambar tidak boleh kosong';
    } else {
      imageError.value = '';
    }
    if (judulError.value.isEmpty &&
        penulisError.value.isEmpty &&
        penerbitError.value.isEmpty &&
        tahunError.value.isEmpty &&
        kategoriError.value.isEmpty &&
        deskripsiError.value.isEmpty) {
      try {
        isLoading.value = true;
        String? digitalBookUrl = '';
        // if (isDigital.value == true) {
        //   digitalBookUrl = await uploadFileToCloudinary(
        //     File(digitalBookPath.value),
        //   );
        // } else {
        //   digitalBookUrl = dataDigitalBookUrl.value;
        // }
        if (isDigital.value == true) {
          if (digitalBookPath.value.isEmpty) {
            digitalBookUrl = digitalBookController.text;
          } else {
            File digitalBookFile = File(digitalBookPath.value);
            String fileName = digitalBookFile.path.split('/').last;
            digitalBookUrl = await SupabaseService().uploadFile(
              digitalBookFile,
              fileName,
            );
          }
        }
        var imagePath = '';
        if (mediaPath.value != '') {
          imagePath = await uploadFileToCloudinary(
            File(mediaPath.value),
          );
        } else {
          imagePath = imageUrl.value;
        }
        var data = {
          'judul': judulController.text,
          'penulis': penulisController.text,
          'penerbit': penerbitController.text,
          'tahun': tahunController.text,
          'stok':
              stokController.text == '' ? 0 : int.parse(stokController.text),
          'status': 'Tersedia',
          'kategori': categorySelected[0]['id'],
          'deskripsi': deskripsiController.text,
          'isDigital': isDigital.value,
          'imageUrl': imagePath,
          'digitalBookUrl': digitalBookUrl,
          'createdAt': DateTime.now(),
          'searchKeywords': generateSearchKeywords(judulController.text),
        };
        FirebaseFirestore.instance
            .collection('books')
            .doc(bookId.value)
            .update(data)
            .then((value) {
          Get.snackbar(
            'Success',
            'Buku berhasil diubah',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.find<LayoutController>().selectedIndex.value = 1;
          Get.offAllNamed('/layout');
        }).catchError((error) {
          print('Error: $error');
          Get.snackbar(
            'Error',
            'Terjadi kesalahan saat mengubah buku',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });

        isLoading.value = false;
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> pickMedia(ImageSource source) async {
    XFile? pickedFile;

    pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      mediaPath.value = pickedFile.path;
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      File file = File(result.files.single.path!);

      digitalBookController.text = platformFile.name;
      digitalBookPath.value = file.path;
    }
  }

  Future<void> getCategories() async {
    isFetching.value = true;
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      categories.clear();
      value.docs.asMap().forEach((index, element) {
        categories.add({
          'index': index,
          'id': element.id,
          'data': element.data(),
        });
      });
      update();
      isFetching.value = false;
    }).catchError((error) {
      print('Error fetching categories: $error');
      isFetching.value = false;
    });
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getCategories();
    var arguments = Get.arguments;
    bookId.value = arguments['documentId'];
    judulController.text = arguments['data']['judul'];
    penulisController.text = arguments['data']['penulis'];
    penerbitController.text = arguments['data']['penerbit'];
    tahunController.text = arguments['data']['tahun'];
    isDigital.value = arguments['data']['isDigital'];
    stokController.text = arguments['data']['stok'].toString();
    deskripsiController.text = arguments['data']['deskripsi'];
    imageUrl.value = arguments['data']['imageUrl'];
    dataDigitalBookUrl.value = arguments['data']['digitalBookUrl'];
    kategoriController.text = categories
        .indexWhere((element) => element['id'] == arguments['data']['kategori'])
        .toString();
    digitalBookController.text = arguments['data']['digitalBookUrl'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
