import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/modules/layout/controllers/layout_controller.dart';
import 'package:library_app/app/widgets/card_collection_book.dart';

import '../controllers/koleksi_controller.dart';

class KoleksiView extends GetView<KoleksiController> {
  const KoleksiView({super.key});
  @override
  Widget build(BuildContext context) {
    final arguments = Get.find<LayoutController>().arguments;

    var category = arguments['category'];
    if (category != null) {
      Get.put(KoleksiController())
          .setCategory(category['name'], category['id']);
    } else {
      Get.put(KoleksiController()).setCategory('', '');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Container(
          width: Get.width,
          padding: EdgeInsets.all(10),
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Mau baca apa hari ini?',
                style: AppTheme.heading1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              TextField(
                onSubmitted: (value) => controller.searchQuery.value = value,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul buku...',
                  hintStyle: AppTheme.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Color(0xff256446),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: AppTheme.heading2.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
                cursorColor: Colors.white,
              ),
            ],
          ),
        ),
        toolbarHeight: 120.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          20,
          12,
          10,
        ),
        child: Column(
          children: [
            Obx(
              () => controller.searchQuery.value.isNotEmpty ||
                      controller.categoryName.value.isNotEmpty
                  ? Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hasil pencarian untuk: ',
                            style: AppTheme.caption.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  controller.searchQuery.value.isNotEmpty
                                      ? controller.searchQuery.value
                                      : controller.categoryName.value,
                                  style: AppTheme.heading2.copyWith(
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  controller.searchQuery.value = '';
                                  controller.searchController.clear();
                                  controller.categoryName.value = '';
                                  controller.categoryId.value = '';
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 10),
            Obx(
              () {
                final searchQuery = controller.searchQuery.value.trim();
                final categoryId = controller.categoryId.value.trim();

                Query bookQuery =
                    FirebaseFirestore.instance.collection('books');

                if (searchQuery.isEmpty && categoryId.isEmpty) {
                  bookQuery = bookQuery.orderBy('createdAt', descending: true);
                } else if (searchQuery.isNotEmpty && categoryId.isEmpty) {
                  bookQuery = bookQuery
                      .where('searchKeywords', arrayContains: searchQuery)
                      .orderBy('createdAt', descending: true);
                } else if (searchQuery.isEmpty && categoryId.isNotEmpty) {
                  bookQuery = bookQuery
                      .where('kategori', isEqualTo: categoryId)
                      .orderBy('createdAt', descending: true);
                } else {
                  bookQuery = bookQuery
                      .where('searchKeywords', arrayContains: searchQuery)
                      .where('kategori', isEqualTo: categoryId)
                      .orderBy('createdAt', descending: true);
                }

                final bookStream = bookQuery.snapshots();
                return StreamBuilder<QuerySnapshot>(
                  stream: bookStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Center(
                          child: Text(
                            'Tidak ada data ditemukan',
                            style: AppTheme.heading3.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.5,
                          ),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            var item =
                                documents[index].data() as Map<String, dynamic>;
                            Color containerColor = Colors.white;
                            var categoryFuture = FirebaseFirestore.instance
                                .collection('categories')
                                .doc(item['kategori'])
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
                                    child: Text(
                                        'Error: ${categorySnapshot.error}'),
                                  );
                                } else if (!categorySnapshot.hasData) {
                                  return Center(
                                    child: Text('Category not found'),
                                  );
                                } else {
                                  final categoryData = categorySnapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return CardCollection(
                                    item: item,
                                    categoryData: categoryData,
                                    containerColor: containerColor,
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    }
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
