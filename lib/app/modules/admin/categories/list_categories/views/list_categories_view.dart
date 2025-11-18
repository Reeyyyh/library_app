import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/list_categories_controller.dart';

class ListCategoriesView extends GetView<ListCategoriesController> {
  const ListCategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Daftar Kategori'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
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
                  final item = documentSnaphot.data() as Map<String, dynamic>;
                  final documentId = documentSnaphot.id;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: AppTheme.heading2.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item['name'],
                              style: AppTheme.heading2.copyWith(
                                fontSize: 16,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(
                          '/update-category',
                          arguments: {
                            'documentId': documentId,
                            'data': item,
                          },
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Are you sure you want to delete this data?',
                                    style: AppTheme.heading2.copyWith(
                                      fontSize: 16,
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
                                          Get.back();
                                          FirebaseFirestore.instance
                                              .collection('categories')
                                              .doc(documentId)
                                              .delete()
                                              .then(
                                                (value) => {
                                                  Get.snackbar(
                                                    'Berhasil',
                                                    'Berhasil menghapus data',
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                  ),
                                                },
                                              );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.primaryColor,
                                        ),
                                        child: Text(
                                          'Hapus',
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
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () => Get.toNamed('/create-category'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
