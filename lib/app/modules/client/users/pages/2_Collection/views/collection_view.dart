import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/views/list_categories_view.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/controllers/collection_controller.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/book_detail_view.dart';
import 'package:library_app/app/modules/client/users/widgets/book_not_found.dart';
import 'package:library_app/app/modules/client/users/widgets/category_without_book.dart';
import 'package:library_app/app/modules/client/users/widgets/collection_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionController controller = Get.put(CollectionController());

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Container(
          height: 120,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mau baca apa hari ini?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.searchController,
                onChanged: (value) => controller.searchQuery.value = value,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul buku...',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: const Color(0xff256446),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
            ],
          ),
        ),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final filteredBooks = controller.filteredBooks;
            final isSearching = controller.searchQuery.isNotEmpty;
            final hasSelectedCategory =
                controller.selectedCategoryName != 'Semua';

            if (filteredBooks.isEmpty) {
              if (isSearching) {
                return const BookNotFound();
              }

              if (hasSelectedCategory) {
                return CategoryWithoutBook(
                  categoryName: controller.selectedCategoryName,
                );
              }

              return const BookNotFound();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== CATEGORY TEXT =====
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => Get.to(
                      () => ListCategoriesView(),
                    ),
                    child: Text(
                      'Category : ${controller.selectedCategoryName}',
                      style: CustomAppTheme.smallText.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ),
                if (controller.searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hasil pencarian untuk: "${controller.searchQuery}"',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: controller.clearSearch,
                        )
                      ],
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredBooks.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return CollectionCard(
                        bookData: filteredBooks[index],
                        onTap: () {
                          Get.to(() =>
                              BookDetailView(bookData: filteredBooks[index]));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// merge
