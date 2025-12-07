import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';


class BookNotFound extends StatelessWidget {
  final String message;

  const BookNotFound({
    Key? key,
    this.message = "Buku tidak ditemukan",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book,
                size: 60,
                color: CustomAppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: CustomAppTheme.bodyText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Coba cari judul lain atau cek koleksi terbaru kami!",
                style: CustomAppTheme.smallText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
