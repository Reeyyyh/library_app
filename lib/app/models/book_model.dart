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
}
