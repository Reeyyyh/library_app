import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/controllers/list_categories_controller.dart';
import 'package:library_app/app/modules/client/users/widgets/category_empty.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class ListCategoriesView extends StatelessWidget {
  final ListCategoriesController controller = Get.put(ListCategoriesController());

  ListCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Kategori'),
        backgroundColor: CustomAppTheme.backgroundColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.categories.isEmpty) {
          return const CategoryEmpty();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index]; // sekarang Category model
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    // Optional: aksi saat kategori diklik
                    // Misal: navigate ke daftar buku berdasarkan kategori
                    // Get.to(() => BooksByCategoryView(category: category));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Center(
                      child: Text(
                        category.name, // gunakan property model
                        style: CustomAppTheme.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
