import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/build_rating.dart';

class cardTestimoniAdmin extends StatelessWidget {
  const cardTestimoniAdmin({
    super.key,
    required this.item,
    required this.userData,
    required this.historyData,
    required this.bookData,
    required this.documentId,
  });

  final Map<String, dynamic> item;
  final Map<String, dynamic> userData;
  final Map<String, dynamic> historyData;
  final Map<String, dynamic> bookData;
  final String documentId;

  @override
  Widget build(BuildContext context) {
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildList('Nama', userData['name']),
            buildList('Email', userData['email']),
            Divider(),
            buildList('Judul', bookData['judul']),
            buildList('Pengarang', bookData['penulis']),
            buildList('Tahun', bookData['tahun']),
            Divider(),
            buildList('Kode Pinjam', historyData['redeem_code']),
            Row(
              children: <Widget>[
                Text(
                  'Rating: ',
                  style: AppTheme.heading2.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                buildRating(rating: item['rating'])
              ],
            ),
            buildList(
                'Testimoni', 'Buku yang sangat membantu saya dalam belajar.'),
          ],
        ),
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
                                .collection('testimoni')
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

  Wrap buildList(String title, String value) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$title: ',
          style: AppTheme.heading2.copyWith(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: AppTheme.heading2.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
