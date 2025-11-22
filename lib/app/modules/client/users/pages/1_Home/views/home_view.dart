import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/client/users/pages/1_Home/controllers/home_controller.dart';
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

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomAppTheme.backgroundColor,
        title: Obx(() {
          final user = auth.userData;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // === Welcome text ===
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${user['name'] ?? ''}",
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

              // === Profile picture / Initial ===
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: CustomAppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Logout dari aplikasi?",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => auth.logout(),
                                child: const Text("Logout"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: (user['image'] ?? '').isNotEmpty
                      ? CachedNetworkImageProvider(user['image'])
                      : null,
                  backgroundColor: (user['image'] ?? '').isEmpty
                      ? CustomAppTheme.primaryColor
                      : Colors.transparent,
                  child: (user['image'] ?? '').isEmpty
                      ? Text(
                          (user['name'] ?? "U")[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
            ],
          );
        }),
      ),

      // ==========================
      // BODY
      // ==========================
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCategories();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ===================== CAROUSEL =====================
            ImageCarousel(
              imagePaths: [
                'assets/img/banner1.png',
                'assets/img/banner2.png',
                'assets/img/banner3.jpg',
              ],
            ),

            const SizedBox(height: 20),

            // ===================== KATEGORI =====================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Kategori Buku",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Show More"),
              ],
            ),

            const SizedBox(height: 10),

            StreamBuilder<List<Map<String, dynamic>>>(
              stream: controller.getTopCategoriesStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final categories = snapshot.data!;

                if (categories.isEmpty) {
                  return const CategoryEmpty();
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 0.35,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category['name'] ?? "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomAppTheme.bodyText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 30),

            // ===================== BUKU TERBARU =====================
            const Text(
              "Buku Terbaru",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("books")
                  .orderBy("createdAt", descending: true)
                  .limit(4)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const BookEmpty();
                }

                return StreamBuilder(
                  stream: controller.getLatestBooks(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    final docs = snapshot.data!.docs;

                    return Column(
                      children: docs.map((d) {
                        final item = d.data() as Map<String, dynamic>;
                        return LatesBookCard(item: item);
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
