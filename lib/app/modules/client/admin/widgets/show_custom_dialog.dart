import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/3_ListCategory/controllers/listcategory_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

// Dialog konfirmasi umum (hapus / aksi penting)
void showCustomDeleteDialog({
  required String title,        // Judul dialog
  required String message,      // Pesan konfirmasi
  required VoidCallback onConfirm, // Aksi saat tombol konfirmasi ditekan
  String confirmText = 'OK',    // Teks tombol konfirmasi
  Color confirmColor = CustomAppTheme.primaryColor, // Warna tombol konfirmasi
  bool showCancel = true,       // Menampilkan tombol batal atau tidak
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Sudut dialog melengkung
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Tinggi dialog menyesuaikan isi
          children: [
            // Judul dialog
            Text(
              title,
              style: CustomAppTheme.heading4.copyWith(color: confirmColor),
            ),
            const SizedBox(height: 10),

            // Pesan konfirmasi
            Text(
              message,
              style: CustomAppTheme.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Tombol aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol batal (opsional)
                if (showCancel)
                  OutlinedButton(
                    onPressed: () => Get.back(), // Tutup dialog
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: confirmColor),
                    ),
                    child: Text(
                      'Batal',
                      style: CustomAppTheme.buttonText.copyWith(
                        color: confirmColor,
                      ),
                    ),
                  ),
                if (showCancel) const SizedBox(width: 10),

                // Tombol konfirmasi
                ElevatedButton(
                  onPressed: onConfirm, // Jalankan aksi konfirmasi
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                  ),
                  child: Text(
                    confirmText,
                    style: CustomAppTheme.buttonText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Dialog tambah & edit kategori
void showCategoryAddUpdateDialog({
  required ListCategoryController controller, // Controller kategori
  bool isEdit = false,        // Mode edit atau tambah
  String? currentName,        // Nama kategori lama (jika edit)
  String? id,                 // ID kategori (jika edit)
}) {
  // Controller input nama kategori
  final nameController = TextEditingController(
    text: currentName ?? '',
  );

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Judul dialog
            Text(
              isEdit ? 'Edit Category' : 'Tambah Category',
              style: CustomAppTheme.heading4.copyWith(
                color: CustomAppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),

            // Input nama kategori
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Category',
                hintText: 'Masukkan nama category',
                labelStyle: CustomAppTheme.subheading,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: CustomAppTheme.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: CustomAppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol batal
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: CustomAppTheme.primaryColor,
                    ),
                  ),
                  child: Text(
                    'Batal',
                    style: CustomAppTheme.buttonText.copyWith(
                      color: CustomAppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Tombol tambah / update
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;

                    // Mode edit kategori
                    if (isEdit && id != null) {
                      controller.updateCategory(id, name);
                    } 
                    // Mode tambah kategori
                    else {
                      controller.addCategory(name);
                    }

                    Get.back(); // Tutup dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomAppTheme.primaryColor,
                  ),
                  child: Text(
                    isEdit ? 'Update' : 'Tambah',
                    style: CustomAppTheme.buttonText,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
