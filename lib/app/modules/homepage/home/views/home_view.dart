import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';
import 'package:library_app/app/widgets/card_lates_book.dart';
import 'package:library_app/app/widgets/image_carousel.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      'Welcome, ${controller.name.value}',
                      style: AppTheme.heading1.copyWith(fontSize: 20),
                    )),
                Text(
                  'Membaca, Membuka Jendela Dunia.',
                  style: AppTheme.caption.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Are you sure you want to logout?',
                          style: AppTheme.heading2.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: AppTheme.bodyText.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                Get.find<AuthController>().logout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                              ),
                              child: Text(
                                'Logout',
                                style: AppTheme.bodyText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Obx(
                () => controller.imageUrl.value.isEmpty
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text(
                          controller.name.value[0],
                          style: AppTheme.heading1.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                            controller.imageUrl.value),
                      ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCategories();
          controller.getUserData();
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ImageCarousel(
                imagePaths: [
                  'assets/banner1.png',
                  'assets/banner2.png',
                  'assets/banner3.jpg',
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Kategori Buku',
                    style: AppTheme.heading1.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/kategori');
                    },
                    child: Text(
                      'Lihat Semua',
                      style: AppTheme.caption.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1 / 0.35,
                        ),
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          return GestureDetector(
                            onTap: () {
                              Get.find<LayoutController>().changeTabIndex(1,
                                  newArguments: {'category': category});
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                10,
                              ), // Memberikan padding pada konten
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppTheme.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Center(
                                  child: Text(
                                    category['name'],
                                    textAlign: TextAlign.center,
                                    style: AppTheme.bodyText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Buku Terbaru',
                    style: AppTheme.heading1.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('books')
                    .limit(4)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final documents = snapshot.data!.docs;
                    if (documents.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data',
                          style: AppTheme.heading3.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final documentSnaphot = documents[index];
                          final item =
                              documentSnaphot.data() as Map<String, dynamic>;

                          var categoryFuture = FirebaseFirestore.instance
                              .collection('categories')
                              .doc(documentSnaphot['kategori'])
                              .get();
                          return FutureBuilder<DocumentSnapshot>(
                            future: categoryFuture,
                            builder: (context, categorySnapshot) {
                              if (categorySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (categorySnapshot.hasError) {
                                return Center(
                                  child:
                                      Text('Error: ${categorySnapshot.error}'),
                                );
                              } else if (!categorySnapshot.hasData) {
                                return Center(
                                  child: Text('Category not found'),
                                );
                              } else {
                                final categoryData = categorySnapshot.data!
                                    .data() as Map<String, dynamic>;
                                return LatesBookCard(
                                    item: item, categoryData: categoryData);
                              }
                            },
                          );
                        },
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
