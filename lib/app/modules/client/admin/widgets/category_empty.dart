import 'package:flutter/material.dart';

class CategoryEmpty extends StatelessWidget {
  const CategoryEmpty({super.key});
// Widget untuk menampilkan pesan ketika tidak ada kategori yang tersedia
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category_outlined,
            size: 50,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 10),
          Text(
            'Belum ada kategori.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Klik tombol + untuk menambahkan category baru.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
