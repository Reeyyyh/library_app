import 'package:flutter/material.dart';
import 'package:library_app/app/models/admin/book_model.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onTap,
  });

  Widget _placeholder() {
    return Container(
      width: 55,
      height: 80,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: book.image.isNotEmpty
              ? Image.network(
                  book.image,
                  width: 55,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),
        title: Text(
          book.judul,
          style: CustomAppTheme.heading2.copyWith(fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          book.penulis,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
        ),
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
