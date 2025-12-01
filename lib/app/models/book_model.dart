import 'package:cloud_firestore/cloud_firestore.dart';

// Enum yang menentukan status buku (tersedia atau tidak tersedia)
enum BookStatus {
  /// Buku bisa dipinjam.
  tersedia,

  /// Buku tidak bisa dipinjam (habis / dipakai / hilang, dll).
  tidakTersedia,
}

/// Extension untuk helper terkait enum [BookStatus].
extension BookStatusExtension on BookStatus {
  /// Mengubah enum ke value string yang disimpan di Firestore.
  String toValue() {
    switch (this) {
      case BookStatus.tersedia:
        return "tersedia";
      case BookStatus.tidakTersedia:
        return "tidak_tersedia";
    }
  }

  // Label yang ditampilkan di UI
  String get label {
    switch (this) {
      case BookStatus.tersedia:
        return "Tersedia";
      case BookStatus.tidakTersedia:
        return "Tidak Tersedia";
    }
  }

  /// Helper untuk mengubah string dari Firestore menjadi enum [BookStatus].
  /// Jika value tidak dikenal, default ke [BookStatus.tidakTersedia].
  static BookStatus fromValue(String value) {
    switch (value.toLowerCase()) {
      case "tersedia":
        return BookStatus.tersedia;
      case "tidak_tersedia":
        return BookStatus.tidakTersedia;
      default:
        return BookStatus.tidakTersedia;
    }
  }
}

// Model buku yang merepresentasikan data buku dalam sistem
class BookModel {
  final String id;               // ID dokumen Firestore
  final String judul;            // Judul buku
  final String penulis;          // Penulis buku
  final String penerbit;         // Penerbit buku
  final String tahun;            // Tahun terbit
  final int stok;                // Jumlah stok buku
  final BookStatus status;       // Status ketersediaan buku
  final String kategori;         // Kategori buku
  final String deskripsi;        // Deskripsi singkat buku
  final String image;            // URL gambar buku
  final Timestamp? createdAt;    // Waktu data dibuat

  // Konstruktor model buku
  BookModel({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahun,
    required this.stok,
    required this.status,
    required this.kategori,
    required this.deskripsi,
    required this.image,
    this.createdAt,
  });

  // Factory constructor: mengubah data Firestore menjadi objek BookModel
  factory BookModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BookModel(
      id: doc.id,
      judul: data['judul'] ?? '',
      penulis: data['penulis'] ?? '',
      penerbit: data['penerbit'] ?? '',
      tahun: data['tahun'] ?? '',
      stok: data['stok'] ?? 0,
      status: BookStatusExtension.fromValue(
        data['status'] ?? 'tidak_tersedia',
      ),
      kategori: data['kategori'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      image: data['image'] ?? '',
      createdAt: data['createdAt'],
    );
  }

  // Mengubah objek BookModel menjadi format Map untuk disimpan ke Firestore
  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'penulis': penulis,
      'penerbit': penerbit,
      'tahun': tahun,
      'stok': stok,
      'status': status.toValue(), // simpan sebagai string
      'kategori': kategori,
      'deskripsi': deskripsi,
      'image': image,
      // Jika belum ada createdAt, gunakan Timestamp.now()
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }
}
