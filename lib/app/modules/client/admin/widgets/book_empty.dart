import 'package:flutter/material.dart';
// widget untuk menampilkan pesan ketika tidak ada buku yang tersedia
class BookEmpty extends StatelessWidget {
  const BookEmpty({super.key});
// Membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Lebar penuh agar tampilan rata kiri-kanan
      padding: const EdgeInsets.all(20), // Ruang dalam container
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Jarak dari sisi luar widget
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background abu-abu muda
        borderRadius: BorderRadius.circular(12), // Sudut melengkung agar lebih estetis
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi berdasarkan isi
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 50,
            color: Colors.grey[500], // Ikon buku berwarna abu abu
          ),
          const SizedBox(height: 10), // Jarak antar elemen teks dan icon
          Text(
            'Belum ada buku.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600, // Tulisan sedikit tebal
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Klik tombol + untuk menambahkan buku baru.',
            textAlign: TextAlign.center, // Agar teks menjadi rata tengah
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14, // Ukuran teks lebih kecil sebagai subtitle
            ),
          ),
        ],
      ),
    );
  }
}
