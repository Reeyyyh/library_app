import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  // Widget untuk menampilkan satu kategori dengan aksi edit & delete
  final String categoryName;
  final VoidCallback? onEdit;   // Fungsi ketika tombol edit ditekan
  final VoidCallback? onDelete; // Fungsi ketika tombol hapus ditekan
// Konstruktor Category Card
  const CategoryCard({
    super.key,
    required this.categoryName,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        // Menampilkan nama kategori pada card
        title: Text(
          categoryName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol untuk mengedit kategori
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            // Tombol untuk menghapus kategori
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
            // Icon draggable (opsional jika ingin reorder list kedepannya)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(Icons.drag_handle, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
