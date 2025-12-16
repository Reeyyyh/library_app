import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/client/admin/pages/2_ListBook/controllers/createbook_controller.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_input.dart';

class CreatebookView extends StatelessWidget {
  CreatebookView({super.key});

  final controller = Get.put(CreatebookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Tambah Buku",
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== IMAGE PICKER ==========
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    image: controller.imageFile.value != null
                        ? DecorationImage(
                            image: FileImage(controller.imageFile.value!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.imageFile.value == null
                      ? const Center(
                          child: Text(
                            "Upload Gambar",
                            style: TextStyle(color: Colors.black54),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // ========== INPUT FIELD ==========
              Obx(
                () => CustomInput(
                  labelText: "Judul",
                  hintText: "Masukkan Judul",
                  controller: controller.judulC,
                  onChanged: (_) => controller.judulError.value = '',
                  errorMessage: controller.judulError.value,
                  showSuccessBorder: controller.judulSuccess.value,
                ),
              ),

              Obx(
                () => CustomInput(
                  labelText: "Penulis",
                  hintText: "Masukkan Penulis",
                  controller: controller.penulisC,
                  onChanged: (_) => controller.penulisError.value = '',
                  errorMessage: controller.penulisError.value,
                  showSuccessBorder: controller.penulisSuccess.value,
                ),
              ),

              Obx(
                () => CustomInput(
                  labelText: "Penerbit",
                  hintText: "Masukkan Penerbit",
                  controller: controller.penerbitC,
                  onChanged: (_) => controller.penerbitError.value = '',
                  errorMessage: controller.penerbitError.value,
                  showSuccessBorder: controller.penerbitSuccess.value,
                ),
              ),

              Obx(() => CustomInput(
                    labelText: "Tahun",
                    hintText: "Masukkan Tahun",
                    controller: controller.tahunC,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => controller.tahunError.value = '',
                    errorMessage: controller.tahunError.value,
                    showSuccessBorder: controller.tahunSuccess.value,
                  )),

              Obx(
                () => CustomInput(
                  labelText: "Stok",
                  hintText: "Masukkan Stok",
                  controller: controller.stokC,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => controller.stokError.value = '',
                  errorMessage: controller.stokError.value,
                  showSuccessBorder: controller.stokSuccess.value,
                ),
              ),

              const Text("Kategori"),
              Obx(() {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.kategoriSuccess.value
                          ? Colors.green
                          : (controller.kategoriError.value.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedCategory.value.isEmpty
                        ? null
                        : controller.selectedCategory.value,
                    isExpanded: true,
                    hint: const Text("Pilih Kategori"),
                    items: controller.categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.selectedCategory.value = val;
                    },
                    underline: const SizedBox(), // hilangkan underline default
                  ),
                );
              }),

              // ========== STATUS DROPDOWN ==========
              const Text("Status"),
              Obx(() {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<BookStatus>(
                    value: controller.status.value,
                    isExpanded: true,
                    hint: const Text("Pilih Status"),
                    items: BookStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) controller.status.value = val;
                    },
                    underline: const SizedBox(),
                  ),
                );
              }),

              const SizedBox(height: 16),
              Obx(
                () => CustomInput(
                  labelText: "Deskripsi",
                  hintText: "Masukkan Deskripsi",
                  controller: controller.deskripsiC,
                  maxLines: 5,
                  onChanged: (_) => controller.deskripsiError.value = '',
                  errorMessage: controller.deskripsiError.value,
                  showSuccessBorder: controller.deskripsiSuccess.value,
                ),
              ),

              const SizedBox(height: 30),

              // ========== TAMPILAN BUTTON SIMPAN ==========
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomAppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.createBook(),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Simpan Buku",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
