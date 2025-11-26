import 'package:cloud_firestore/cloud_firestore.dart';

enum BookStatus {
  tersedia,
  tidakTersedia,
}

extension BookStatusExtension on BookStatus {
  String toValue() {
    switch (this) {
      case BookStatus.tersedia:
        return "tersedia";
      case BookStatus.tidakTersedia:
        return "tidak_tersedia";
    }
  }

  String get label {
    switch (this) {
      case BookStatus.tersedia:
        return "Tersedia";
      case BookStatus.tidakTersedia:
        return "Tidak Tersedia";
    }
  }

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

class BookModel {
  final String id;
  final String judul;
  final String penulis;
  final String penerbit;
  final String tahun;
  final int stok;
  final BookStatus status;
  final String kategori;
  final String deskripsi;
  final String image;
  final Timestamp? createdAt;

  // Tambahan opsional
  final String? isbn;
  final int? jumlahHalaman;
  final String? bahasa;
  final String? lokasiRak;

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
    this.isbn,
    this.jumlahHalaman,
    this.bahasa,
    this.lokasiRak,
  });

  factory BookModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BookModel(
      id: doc.id,
      judul: data['judul'] ?? '',
      penulis: data['penulis'] ?? '',
      penerbit: data['penerbit'] ?? '',
      tahun: data['tahun'] ?? '',
      stok: data['stok'] ?? 0,
      status: BookStatusExtension.fromValue(data['status'] ?? 'tidak_tersedia'),
      kategori: data['kategori'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      image: data['image'] ?? '',
      createdAt: data['createdAt'],
      isbn: data['isbn'],
      jumlahHalaman: data['jumlahHalaman'],
      bahasa: data['bahasa'],
      lokasiRak: data['lokasiRak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'penulis': penulis,
      'penerbit': penerbit,
      'tahun': tahun,
      'stok': stok,
      'status': status.toValue(),
      'kategori': kategori,
      'deskripsi': deskripsi,
      'image': image,
      'createdAt': createdAt ?? Timestamp.now(),
      // Tambahan opsional
      'isbn': isbn,
      'jumlahHalaman': jumlahHalaman,
      'bahasa': bahasa,
      'lokasiRak': lokasiRak,
    };
  }
}
