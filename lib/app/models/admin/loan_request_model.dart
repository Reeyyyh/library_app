class LoanRequest {
  final String nama;
  final String email;
  final String judulBuku;
  final String category;
  final String tanggalPinjam;
  final String tanggalKembali;
  final String status;

  LoanRequest({
    required this.nama,
    required this.email,
    required this.judulBuku,
    required this.category,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.status,
  });

  factory LoanRequest.fromMap(Map<String, dynamic> map) {
    return LoanRequest(
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      judulBuku: map['judulBuku'] ?? '',
      category: map['category'] ?? '',
      tanggalPinjam: map['tanggalPinjam'] ?? '',
      tanggalKembali: map['tanggalKembali'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'email': email,
      'judulBuku': judulBuku,
      'category': category,
      'tanggalPinjam': tanggalPinjam,
      'tanggalKembali': tanggalKembali,
      'status': status,
    };
  }
}
