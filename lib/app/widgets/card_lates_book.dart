import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';

class LatesBookCard extends StatelessWidget {
  const LatesBookCard({
    super.key,
    required this.item,
    required this.categoryData,
  });

  final Map<String, dynamic> item;
  final Map<String, dynamic> categoryData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/book-detail',
          arguments: {
            'data': item,
            'category': categoryData,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
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
          contentPadding:
              EdgeInsets.all(8), // Menambah padding untuk elemen di dalam
          title: Row(
            children: [
              Hero(
                tag: item['imageUrl'],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item['imageUrl'],
                    width: 60, // Ukuran gambar tetap konsisten
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Menata kolom untuk teks
              Expanded(
                // Membuat teks fleksibel
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item['judul'],
                      style: AppTheme.heading2.copyWith(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4), // Memberikan jarak antar baris
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Ubah ke start agar lebih konsisten
                      children: <Widget>[
                        Text(
                          'By : ',
                          style: AppTheme.caption.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          item['penulis'],
                          style: AppTheme.heading2.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis, // Menambahkan overflow
                        ),
                      ],
                    ),
                    const SizedBox(height: 4), // Memberikan jarak antar baris
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            categoryData['name'] ?? 'No Category',
                            style: AppTheme.bodyText.copyWith(
                              fontSize: 12,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['tahun'],
                            style: AppTheme.bodyText.copyWith(
                              fontSize: 12,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['status'] ?? 'No Genre',
                            style: AppTheme.bodyText.copyWith(
                              fontSize: 12,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
