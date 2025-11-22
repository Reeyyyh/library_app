import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/pages/3_ListCategory/controllers/listcategory_controller.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';
import 'package:library_app/app/modules/client/admin/widgets/category_card.dart';
import 'package:library_app/app/modules/client/admin/widgets/category_empty.dart';
import 'package:library_app/app/modules/client/admin/widgets/show_custom_dialog.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListCategoryController());

    return Scaffold(
      appBar: AdminAppBar(
        title: "Kategori",
        showBack: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.categories.isEmpty) {
          return const CategoryEmpty();
        }

        return SingleChildScrollView(
          child: ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categories.length,
            onReorder: controller.reorderAll,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Column(
                key: ValueKey(category['id']),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 4)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Kategori Lain",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  CategoryCard(
                    categoryName: category['name'],
                    onEdit: () {
                      showCategoryAddUpdateDialog(
                        controller: controller,
                        isEdit: true,
                        id: category['id'],
                        currentName: category['name'],
                      );
                    },
                    onDelete: () {
                      showCustomDeleteDialog(
                        title: 'Hapus Category',
                        message: 'Apakah yakin ingin menghapus category ini?',
                        confirmColor: Colors.redAccent,
                        confirmText: 'Hapus',
                        onConfirm: () {
                          controller.deleteCategory(category['id']);
                          Get.back();
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomAppTheme.primaryColor,
        onPressed: () {
          showCategoryAddUpdateDialog(controller: controller);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
