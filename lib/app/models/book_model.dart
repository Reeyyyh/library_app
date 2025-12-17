<<<<<<< HEAD
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
  final String kategoriId;
  final String deskripsi;
  final String image;
  final String? isbn;
  final int? jumlahHalaman;
  final String? bahasa;
  final String? lokasiRak;
  final DateTime? createdAt;
=======
import 'package:cloud_firestore/cloud_firestore.dart';

enum BookStatus { tersedia, tidakTersedia }

extension BookStatusX on BookStatus {
  // Mengubah ke string database
  String get value =>
      this == BookStatus.tersedia ? "tersedia" : "tidak_tersedia";

  // Mengubah ke label UI
  String get label =>
      this == BookStatus.tersedia ? "Tersedia" : "Tidak Tersedia";

  // Helper konversi dari string database ke Enum
  static BookStatus fromString(String? val) =>
      val == "tersedia" ? BookStatus.tersedia : BookStatus.tidakTersedia;
}

class BookModel {
  // Deklarasi ringkas untuk tipe data yang sama
  final String id, judul, penulis, penerbit, tahun, kategori, deskripsi, image;
  final int stok;
  final BookStatus status;
  final Timestamp? createdAt;
>>>>>>> rakarajinibadah

  BookModel({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahun,
    required this.stok,
    required this.status,
    required this.kategoriId,
    required this.deskripsi,
    required this.image,
    this.isbn,
    this.jumlahHalaman,
    this.bahasa,
    this.lokasiRak,
    this.createdAt,
  });

<<<<<<< HEAD
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      judul: map['judul'],
      penulis: map['penulis'],
      penerbit: map['penerbit'],
      tahun: map['tahun'],
      stok: map['stok'] ?? 0,
      status: BookStatusExtension.fromValue(map['status'] ?? "tersedia"),
      kategoriId: map['kategori_id'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      image: map['image'] ?? '',
      isbn: map['isbn'],
      jumlahHalaman: map['jumlah_halaman'],
      bahasa: map['bahasa'],
      lokasiRak: map['lokasi_rak'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'penulis': penulis,
      'penerbit': penerbit,
      'tahun': tahun,
      'stok': stok,
      'status': status.toValue(),
      'kategori_id': kategoriId,
      'deskripsi': deskripsi,
      'image': image,
      'isbn': isbn,
      'jumlah_halaman': jumlahHalaman,
      'bahasa': bahasa,
      'lokasi_rak': lokasiRak,
    };
  }
=======
  factory BookModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookModel(
      id: doc.id,
      judul: data['judul'] ?? '',
      penulis: data['penulis'] ?? '',
      penerbit: data['penerbit'] ?? '',
      tahun: data['tahun'] ?? '',
      stok: data['stok'] ?? 0,
      status: BookStatusX.fromString(data['status']),
      kategori: data['kategori'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      image: data['image'] ?? '',
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'penulis': penulis,
        'penerbit': penerbit,
        'tahun': tahun,
        'stok': stok,
        'status': status.value,
        'kategori': kategori,
        'deskripsi': deskripsi,
        'image': image,
        'createdAt': createdAt ?? Timestamp.now(),
      };
>>>>>>> rakarajinibadah
}
