import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_input.dart';
import '../controllers/updatebook_controller.dart';

class UpdatebookView extends StatelessWidget {
  final BookModel book; // Method Menampung data buku yang akan diedit

  const UpdatebookView(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatebookController()); // Memanggil controller edit buku
    controller.loadBook(book); // Mengisi form input dengan data buku awal

    return Scaffold(
      appBar: const AdminAppBar(
        title: "Edit Buku", // Tampilan Judul halaman
        showBack: true, // Tampilkan tombol kembali
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =======================================
            // ========== INPUT FIELD JUDUL ==========
            // =======================================
            Obx(
              () => CustomInput(
                labelText: "Judul",
                hintText: "Masukkan Judul",
                controller: controller.judulC,
                onChanged: (_) => controller.judulError.value = '', // Hapus error jika user mengetik
                errorMessage: controller.judulError.value, // Pesan error validasi
                showSuccessBorder: controller.judulC.text.isNotEmpty, // Border hijau jika isi tidak kosong
              ),
            ),
            const SizedBox(height: 16),

            // FIELD PENULIS
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

            // FIELD PENERBIT
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

            // FIELD TAHUN TERBIT
            Obx(
              () => CustomInput(
                labelText: "Tahun",
                hintText: "Masukkan Tahun",
                controller: controller.tahunC,
                keyboardType: TextInputType.number, // Input hanya angka
                onChanged: (_) => controller.tahunError.value = '',
                errorMessage: controller.tahunError.value,
                showSuccessBorder: controller.tahunC.text.isNotEmpty,
              ),
            ),
            const SizedBox(height: 16),

            // FIELD STOK
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

            // ========================================
            // ========== DROPDOWN KATEGORI ===========
            // ========================================
            const Text("Kategori"), // Label kategori buku
            Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedCategoryId.value.isNotEmpty
                        ? Colors.green // Hijau jika kategori terisi
                        : Colors.grey, // Abu jika belum dipilih
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedCategoryId.value.isEmpty
                      ? null
                      : controller.selectedCategoryId.value,
                  isExpanded: true,
                  hint: const Text("Pilih Kategori"),
                  items: controller.categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat.id, // ⚡ ID dikirim
                      child: Text(cat.name), // ⚡ Name yang ditampilkan
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      controller.selectedCategoryId.value = val; // simpan ID
                    }
                  },
                  underline: const SizedBox(),
                ),
              );
            }),

            const SizedBox(height: 16),

            // ====================================
            // ========== DROPDOWN STATUS =========
            // ====================================
            const Text("Status"), // Menentukan status buku (tersedia / dipinjam / rusak)
            Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green), // Selalu border hijau
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<BookStatus>(
                  value: controller.status.value, // Status terpilih saat ini
                  isExpanded: true,
                  hint: const Text("Pilih Status"),
                  items: BookStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.label), // Tampilkan label status
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.status.value = val;
                  },
                  underline: const SizedBox(),
                ),
              );
            }),

            // FIELD DESKRIPSI
            Obx(
              () => CustomInput(
                labelText: "Deskripsi",
                hintText: "Masukkan Deskripsi",
                controller: controller.deskripsiC,
                maxLines: 5, // Input teks bisa lebih panjang
                onChanged: (_) => controller.deskripsiError.value = '',
                errorMessage: controller.deskripsiError.value,
                showSuccessBorder: controller.deskripsiC.text.isNotEmpty,
              ),
            ),

            const SizedBox(height: 30),

            const Text("Informasi Tambahan (Opsional)",
                style: TextStyle(fontWeight: FontWeight.bold)),

            CustomInput(
              labelText: "ISBN",
              hintText: "ISBN",
              controller: controller.isbnC,
            ),

            const SizedBox(height: 16),

            CustomInput(
              labelText: "Jumlah Halaman",
              hintText: "jumlah halaman",
              controller: controller.jumlahHalamanC,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            CustomInput(
              labelText: "Bahasa Buku",
              hintText: "bahasa buku",
              controller: controller.bahasaC,
            ),

            const SizedBox(height: 16),

            CustomInput(
              labelText: "Lokasi Rak",
              hintText: "lokasi rak",
              controller: controller.lokasiRakC,
            ),

            const SizedBox(height: 32),

            // =============================================
            // ========== BUTTON SIMPAN PERUBAHAN ==========
            // =============================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomAppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: controller.updateBook, // Menjalankan proses update
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
// merge
