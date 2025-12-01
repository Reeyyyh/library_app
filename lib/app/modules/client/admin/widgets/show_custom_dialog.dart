import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/3_ListCategory/controllers/listcategory_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

void showCustomDeleteDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = 'OK',
  Color confirmColor = CustomAppTheme.primaryColor,
  bool showCancel = true,
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: CustomAppTheme.heading4.copyWith(color: confirmColor)),
            const SizedBox(height: 10),
            Text(message, style: CustomAppTheme.bodyText, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showCancel)
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(side: BorderSide(color: confirmColor)),
                    child: Text('Batal', style: CustomAppTheme.buttonText.copyWith(color: confirmColor)),
                  ),
                if (showCancel) const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
                  child: Text(confirmText, style: CustomAppTheme.buttonText),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showCategoryAddUpdateDialog({
  required ListCategoryController controller,
  bool isEdit = false,
  String? currentName,
  String? id,
}) {
  final nameController = TextEditingController(text: currentName ?? '');

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Edit Category' : 'Tambah Category',
              style: CustomAppTheme.heading4.copyWith(
                color: CustomAppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Category',
                hintText: 'Masukkan nama category',
                labelStyle: CustomAppTheme.subheading,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomAppTheme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomAppTheme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: CustomAppTheme.primaryColor),
                  ),
                  child: Text(
                    'Batal',
                    style: CustomAppTheme.buttonText.copyWith(
                      color: CustomAppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    if (isEdit && id != null) {
                      controller.updateCategory(id, name);
                    } else {
                      controller.addCategory(name);
                    }
                    Get.back();
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
// merge