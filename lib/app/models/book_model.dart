import 'package:cloud_firestore/cloud_firestore.dart';

/// Status ketersediaan buku di perpustakaan.
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

  /// Label yang ditampilkan ke user (untuk UI).
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

/// Model data buku yang disimpan di Firestore.
class BookModel {
  /// ID dokumen di Firestore (doc.id).
  final String id;

  /// Judul buku.
  final String judul;

  /// Nama penulis buku.
  final String penulis;

  /// Nama penerbit buku.
  final String penerbit;

  /// Tahun terbit buku (disimpan sebagai string, misal "2020").
  final String tahun;

  /// Jumlah stok buku yang tersedia.
  final int stok;

  /// Status ketersediaan buku (tersedia / tidak tersedia).
  final BookStatus status;

  /// Kategori buku (misal: Pelajaran, Fiksi, Referensi).
  final String kategori;

  /// Deskripsi singkat buku.
  final String deskripsi;

  /// URL gambar cover buku.
  final String image;

  /// Waktu data buku dibuat (timestamp Firestore).
  final Timestamp? createdAt;

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

  /// Factory constructor untuk membangun [BookModel] dari dokumen Firestore.
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

  /// Mengubah objek [BookModel] menjadi Map untuk disimpan ke Firestore.
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
