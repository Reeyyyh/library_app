import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/badge_status.dart';
import 'package:library_app/app/widgets/dateformat.dart';

class cardListHistory extends StatelessWidget {
  const cardListHistory({
    super.key,
    required this.userData,
    required this.bookData,
    required this.categoryData,
    required this.item,
    required this.documentId,
  });

  final Map<String, dynamic> userData;
  final Map<String, dynamic> bookData;
  final Map<String, dynamic> categoryData;
  final Map<String, dynamic> item;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Kode pinjam: ',
                  style: AppTheme.heading2.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  item['redeem_code'],
                  style: AppTheme.heading2.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 2,
              children: <Widget>[
                Text(
                  'Dibuat pada: ',
                  style: AppTheme.heading2.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  dateFormatFromDateTime(item['created_at']),
                  style: AppTheme.heading2.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              'Peminjam',
              style: AppTheme.heading2.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              userData['name'],
              style: AppTheme.heading2.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              userData['email'],
              style: AppTheme.caption.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Text(
              'Buku',
              style: AppTheme.heading2.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              bookData['judul'],
              style: AppTheme.heading2.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              categoryData['name'],
              style: AppTheme.caption.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Text(
              'Detail',
              style: AppTheme.heading2.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              '${item['start_date']} - ${item['end_date']} (${item['duration']})',
              style: AppTheme.heading2.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            BadgeStatus(
              status: item['status'],
            )
          ],
        ),
        onTap: () {
          Get.toNamed(
            '/detail-history',
            arguments: {
              'history': item,
              'user': userData,
              'book': bookData,
              'category': categoryData,
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
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    ),
                                  },
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
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
  }
}
