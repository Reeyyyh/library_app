class LoanRequest {
  final String borrowCode;
  final String uid;
  final String nama;
  final String email;
  final String kelas;
  final String kontak;
  final String judulBuku;
  final String category;
  final String image;
  final String tanggalPinjam;
  final String tanggalKembali;
  final String status;
  final String? returnCode;
  final String? returnDate;

  LoanRequest({
    required this.borrowCode,
    required this.uid,
    required this.nama,
    required this.email,
    required this.kelas,
    required this.kontak,
    required this.judulBuku,
    required this.category,
    required this.image,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.status,
    this.returnCode,
    this.returnDate,
  });

  factory LoanRequest.fromMap(Map<String, dynamic> map) {
    return LoanRequest(
      borrowCode: map['borrowCode'] ?? '',
      uid: map['uid'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      kelas: map['kelas'] ?? '',
      kontak: map['kontak'] ?? '',
      judulBuku: map['judulBuku'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      tanggalPinjam: map['tanggalPinjam'] ?? '',
      tanggalKembali: map['tanggalKembali'] ?? '',
      status: map['status'] ?? 'pending',
      returnCode: map['returnCode'],
      returnDate: map['returnDate'], // tanggal kembali lebih cepat
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'borrowCode': borrowCode,
      'uid': uid,
      'nama': nama,
      'email': email,
      'kelas': kelas,
      'kontak': kontak,
      'judulBuku': judulBuku,
      'category': category,
      'image': image,
      'tanggalPinjam': tanggalPinjam,
      'tanggalKembali': tanggalKembali,
      'status': status,
      'returnCode': returnCode,
      'returnDate': returnDate,
    };
  }
}
