import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/botnav/controllers/user_botnav_controller.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/controllers/list_categories_controller.dart';
import 'package:library_app/app/modules/client/users/widgets/category_empty.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class ListCategoriesView extends StatelessWidget {
  final ListCategoriesController controller =
      Get.put(ListCategoriesController());

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
          itemCount: controller.categories.length + 1,
          itemBuilder: (context, index) {
            final isAllCategory = index == controller.categories.length;

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
                    final botNav = Get.find<UserBotNavController>();

                    if (isAllCategory) {
                      // 🔥 RESET FILTER
                      botNav.selectedCategory.value = null;
                    } else {
                      final category = controller.categories[index];
                      botNav.selectedCategory.value = category;
                    }

                    botNav.changeTabIndex(1);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Center(
                      child: Text(
                        isAllCategory
                            ? 'Semua'
                            : controller.categories[index].name,
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
