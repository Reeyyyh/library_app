/// Model data untuk merepresentasikan 1 permintaan peminjaman buku
/// (loan request) yang disimpan di Firestore / database.
///
/// Biasanya digunakan untuk:
/// - Menampilkan daftar permintaan peminjaman di UI (admin / user)
/// - Menyimpan data peminjaman ketika user melakukan request pinjam buku
class LoanRequest {
  /// Kode unik peminjaman.
  ///
  /// Contoh: "BRW-2025-0001"
  final String borrowCode;

  /// UID user (biasanya diambil dari Firebase Auth).
  final String uid;

  /// Nama peminjam (user).
  final String nama;

  /// Email peminjam.
  final String email;

  /// Judul buku yang dipinjam.
  final String judulBuku;

  /// Kategori buku (misal: "Teknologi", "Novel", "Komik").
  final String category;

  /// URL gambar buku.
  ///
  /// Biasanya berupa link dari Firebase Storage / hosting lain.
  final String image;

  /// Tanggal pinjam dalam format String.
  ///
  /// Contoh format: `"2025-11-24"` atau `"24-11-2025"`,
  /// sesuaikan dengan format yang kamu pakai di app.
  final String tanggalPinjam;

  /// Tanggal kembali dalam format String.
  ///
  /// Digunakan sebagai batas pengembalian buku.
  final String tanggalKembali;

  /// Status permintaan peminjaman.
  ///
  /// Contoh nilai:
  /// - `"pending"`  → menunggu persetujuan
  /// - `"approved"` → disetujui
  /// - `"rejected"` → ditolak
  /// - `"returned"` → buku sudah dikembalikan
  final String status;

  /// Constructor utama untuk membuat instance [LoanRequest].
  ///
  /// Digunakan saat membuat objek peminjaman baru di aplikasi,
  /// sebelum disimpan ke Firestore.
  LoanRequest({
    required this.borrowCode,
    required this.image,
    required this.uid,
    required this.nama,
    required this.email,
    required this.judulBuku,
    required this.category,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.status,
  });

  /// Factory constructor untuk membuat [LoanRequest] dari [Map].
  ///
  /// - [map] biasanya berasal dari `DocumentSnapshot.data()` yang sudah
  ///   di-cast ke `Map<String, dynamic>`.
  /// - Setiap key di [map] harus sesuai dengan nama field di Firestore.
  factory LoanRequest.fromMap(Map<String, dynamic> map) {
    return LoanRequest(
      borrowCode: map['borrowCode'] ?? '',
      uid: map['uid'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
      judulBuku: map['judulBuku'] ?? '',
      category: map['category'] ?? '',
      tanggalPinjam: map['tanggalPinjam'] ?? '',
      tanggalKembali: map['tanggalKembali'] ?? '',
      status: map['status'] ?? 'pending',
    );
  }

  /// Mengubah objek [LoanRequest] menjadi [Map] agar bisa disimpan ke Firestore.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await FirebaseFirestore.instance
  ///   .collection('loan_requests')
  ///   .doc(borrowCode)
  ///   .set(loanRequest.toMap());
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'borrowCode': borrowCode,
      'uid': uid,
      'nama': nama,
      'email': email,
      'image': image,
      'judulBuku': judulBuku,
      'category': category,
      'tanggalPinjam': tanggalPinjam,
      'tanggalKembali': tanggalKembali,
      'status': status,
    };
  }
}
