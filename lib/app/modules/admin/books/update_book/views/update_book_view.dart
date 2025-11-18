import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';
import 'package:library_app/app/widgets/custom_input_file.dart';
import 'package:library_app/app/widgets/custom_select.dart';

import '../controllers/update_book_controller.dart';

class UpdateBookView extends GetView<UpdateBookController> {
  const UpdateBookView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(UpdateBookController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Ubah Buku'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        children: [
          Text(
            'Tambah Buku Baru',
            style: AppTheme.heading2.copyWith(
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  'Silahkan isi form di bawah ini untuk menambahkan book baru',
                  style: AppTheme.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Obx(
              () {
                return controller.imageUrl.value.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          controller.imageUrl.value,
                          width: Get.width * 0.8,
                          height: Get.width,
                          fit: BoxFit.cover,
                        ),
                      )
                    : controller.mediaPath.value.isEmpty
                        ? Image.asset(
                            'assets/upload_image.png',
                            height: 200,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(controller.mediaPath.value),
                              width: Get.width * 0.8,
                              height: Get.width,
                              fit: BoxFit.cover,
                            ),
                          );
              },
            ),
          ),
          Obx(
            () {
              if (controller.imageError.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    '*${controller.imageError.value}',
                    style: GoogleFonts.montserrat(
                      color: Colors.red,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('Pick Image from Gallery'),
                          onTap: () {
                            controller.pickMedia(ImageSource.gallery);
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Pick Image from Camera'),
                          onTap: () {
                            controller.pickMedia(ImageSource.camera);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: IntrinsicWidth(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Upload Image',
                    style: AppTheme.heading3.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.upload_file,
                    color: Colors.white,
                  ),
                ],
              )),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Judul Buku',
              controller: controller.judulController,
              errorMessage: controller.judulError.value,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Penulis Buku',
              controller: controller.penulisController,
              errorMessage: controller.penulisError.value,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Penerbit Buku',
              controller: controller.penerbitController,
              errorMessage: controller.penerbitError.value,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Tahun Terbit',
              controller: controller.tahunController,
              errorMessage: controller.tahunError.value,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => controller.isFetching.value
                ? const Center(child: CircularProgressIndicator())
                : CustomSelect(
                    labelText: 'Pilih Kategori',
                    items: controller.categories,
                    errorMessage: controller.kategoriError.value,
                    controller: controller.kategoriController,
                    onChanged: (value) {
                      controller.kategoriController.text = value.toString();
                    },
                  ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Row(
              children: [
                Checkbox(
                  value: controller.isDigital.value,
                  onChanged: (bool? value) {
                    controller.isDigital.value = value!;
                  },
                ),
                Text(
                  'Apakah buku ini digital?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => controller.isDigital.value
                ? CustomFileInput(
                    pdfUrl: controller.digitalBookController.text,
                    labelText: 'File Digital Book',
                    placeholder: controller.digitalBookController.text == ''
                        ? 'Pilih file PDF'
                        : '',
                    controller: controller.digitalBookController,
                    onPressed: () {
                      controller.pickFile();
                    },
                    errorMessage: controller.digitalBookError.value,
                  )
                : CustomInput(
                    labelText: 'Stok',
                    controller: controller.stokController,
                    errorMessage: controller.stokError.value,
                    isNumber: true,
                    keyboardType: TextInputType.number,
                  ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Deskripsi',
              controller: controller.deskripsiController,
              errorMessage: controller.deskripsiError.value,
              maxLines: 5,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomButton(
              text: 'Save',
              onPressed: controller.onSubmit,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
