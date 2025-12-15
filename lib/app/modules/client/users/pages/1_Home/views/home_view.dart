import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/client/users/botnav/controllers/user_botnav_controller.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/controllers/home_controller.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/views/list_categories_view.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/controllers/collection_controller.dart';
import 'package:library_app/app/modules/client/users/pages/2_Collection/views/book_detail_view.dart';
import 'package:library_app/app/modules/client/users/widgets/book_empty.dart';
import 'package:library_app/app/modules/client/users/widgets/category_empty.dart';
import 'package:library_app/app/modules/client/users/widgets/lates_book_card.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/image_carousel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();

    // Refresh semua data

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomAppTheme.backgroundColor,
        title: Obx(() {
          final user = auth.userModel.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${user?.name ?? 'Guest'}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Membaca membuka jendela dunia",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: (user?.image.isNotEmpty ?? false)
                    ? CachedNetworkImageProvider(user!.image)
                    : null,
                backgroundColor: (user?.image.isEmpty ?? true)
                    ? CustomAppTheme.primaryColor
                    : Colors.transparent,
                child: (user?.image.isEmpty ?? true) && user != null
                    ? Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'G',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ],
          );
        }),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ===== CAROUSEL =====
          ImageCarousel(
            imagePaths: [
              'assets/img/banner1.png',
              'assets/img/banner2.png',
              'assets/img/banner3.jpg',
            ],
          ),
          const SizedBox(height: 20),

          // ===== KATEGORI =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(
                  () => ListCategoriesView(),
                ),
                child: Text(
                  "Show More",
                  style: CustomAppTheme.smallText.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          StreamBuilder<List<CategoryModel>>(
            stream: controller.categoriesStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final cats = snapshot.data!;
              if (cats.isEmpty) return const CategoryEmpty();

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1 / 0.35,
                ),
                itemBuilder: (context, index) {
                  final category = cats[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        if (Get.isRegistered<CollectionController>()) {
                          Get.delete<CollectionController>();
                        }
                        Get.find<UserBotNavController>()
                            .goToCollectionByCategory(category);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          category.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomAppTheme.bodyText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 30),

          // ===== BUKU TERBARU =====
          const Text(
            "Buku Terbaru",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: controller.latestBooksStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final books = snapshot.data!;
              if (books.isEmpty) return const BookEmpty();

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final bookWithCategory = books[index];
                  return InkWell(
                    onTap: () => Get.to(
                        () => BookDetailView(bookData: bookWithCategory)),
                    child: LatesBookCard(bookWithCategory: bookWithCategory),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
