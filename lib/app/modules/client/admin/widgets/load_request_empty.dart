import 'package:flutter/material.dart';

// Widget untuk menampilkan kondisi kosong
// ketika belum ada pengajuan peminjaman buku
class LoadRequestEmpty extends StatelessWidget {
  const LoadRequestEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Lebar penuh agar sejajar dengan list
      padding: const EdgeInsets.all(20), // Padding dalam container
      margin: const EdgeInsets.symmetric(vertical: 8), // Jarak vertikal antar widget
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background abu-abu muda
        borderRadius: BorderRadius.circular(12), // Sudut melengkung
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Tinggi mengikuti isi konten
        children: [
          // Icon inbox sebagai ilustrasi data kosong
          Icon(
            Icons.inbox,
            size: 40,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 10), // Jarak antar icon dan teks
          // Pesan informasi data kosong
          Text(
            'Belum ada pengajuan.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
