class LoanRequest {
  final String borrowCode;
  final String uid;
  final String nama;
  final String email;
  final String judulBuku;
  final String category;
  final String image;

  final String tanggalPinjam;
  final String tanggalKembali;
  final String status;

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
