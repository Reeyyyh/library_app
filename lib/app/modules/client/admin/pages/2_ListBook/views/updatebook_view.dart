import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_input.dart';
import '../controllers/updatebook_controller.dart';

class UpdatebookView extends StatelessWidget {
  final BookModel book;

  const UpdatebookView(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatebookController());
    controller.loadBook(book);

    return Scaffold(
      appBar: const AdminAppBar(
        title: "Edit Buku",
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== INPUT FIELD ==========
            Obx(
              () => CustomInput(
                labelText: "Judul",
                hintText: "Masukkan Judul",
                controller: controller.judulC,
                onChanged: (_) => controller.judulError.value = '',
                errorMessage: controller.judulError.value,
                showSuccessBorder: controller.judulC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => CustomInput(
                labelText: "Penulis",
                hintText: "Masukkan Penulis",
                controller: controller.penulisC,
                onChanged: (_) => controller.penulisError.value = '',
                errorMessage: controller.penulisError.value,
                showSuccessBorder: controller.penulisC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => CustomInput(
                labelText: "Penerbit",
                hintText: "Masukkan Penerbit",
                controller: controller.penerbitC,
                onChanged: (_) => controller.penerbitError.value = '',
                errorMessage: controller.penerbitError.value,
                showSuccessBorder: controller.penerbitC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => CustomInput(
                labelText: "Tahun",
                hintText: "Masukkan Tahun",
                controller: controller.tahunC,
                keyboardType: TextInputType.number,
                onChanged: (_) => controller.tahunError.value = '',
                errorMessage: controller.tahunError.value,
                showSuccessBorder: controller.tahunC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => CustomInput(
                labelText: "Stok",
                hintText: "Masukkan Stok",
                controller: controller.stokC,
                keyboardType: TextInputType.number,
                onChanged: (_) => controller.stokError.value = '',
                errorMessage: controller.stokError.value,
                showSuccessBorder: controller.stokC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            // ========== DROPDOWN KATEGORI ==========
            const Text("Kategori"),
            Obx(() {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedCategory.value.isNotEmpty
                        ? Colors.green
                        : Colors.grey,
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
                  underline: const SizedBox(),
                ),
              );
            }),
            const SizedBox(height: 16),

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

            Obx(
              () => CustomInput(
                labelText: "Deskripsi",
                hintText: "Masukkan Deskripsi",
                controller: controller.deskripsiC,
                maxLines: 5,
                onChanged: (_) => controller.deskripsiError.value = '',
                errorMessage: controller.deskripsiError.value,
                showSuccessBorder: controller.deskripsiC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 24),

            // ========== BUTTON SIMPAN PERUBAHAN ==========
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomAppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: controller.updateBook,
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
