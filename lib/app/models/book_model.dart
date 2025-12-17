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
}
