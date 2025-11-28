class LoanRequest {
  final String? id;
  final String borrowCode;
  // user model
  final String uid;
  final String nama;
  final String email;
  final String kelas;
  final String kontak;
  // book model
  final String bookId;
  final String judulBuku;
  final String tahun;
  final String penulis;
  final String penerbit;
  final String category;
  final String image;
  final String? isbn;
  final int? jumlahHalaman;
  final String? bahasa;
  final String? lokasiRak;
  final String tanggalPinjam;
  final String tanggalKembali;
  final String requestStatus;
  final String? returnCode;
  final String? returnDate;

  LoanRequest({
    this.id,
    required this.borrowCode,
    // user model
    required this.uid,
    required this.nama,
    required this.email,
    required this.kelas,
    required this.kontak,
    // book model
    required this.bookId,
    required this.judulBuku,
    required this.tahun,
    required this.penulis,
    required this.penerbit,
    required this.category,
    required this.image,
    this.isbn,
    this.jumlahHalaman,
    this.bahasa,
    this.lokasiRak,
    // for load
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.requestStatus,
    this.returnCode,
    this.returnDate,
  });

  factory LoanRequest.fromMap(Map<String, dynamic> map, String id) {
    return LoanRequest(
      id: id,
      borrowCode: map['borrowCode'] ?? '',
      // user model
      uid: map['uid'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      kelas: map['kelas'] ?? '',
      kontak: map['kontak'] ?? '',
      // book model
      bookId: map['bookId'] ?? '',
      judulBuku: map['judulBuku'] ?? '',
      penulis: map['penulis'] ?? '',
      tahun: map['tahun'] ?? '',
      penerbit: map['penerbit'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      isbn: map['isbn'],
      jumlahHalaman: map['jumlahHalaman'],
      bahasa: map['bahasa'],
      lokasiRak: map['lokasiRak'],
      // for loan
      tanggalPinjam: map['tanggalPinjam'] ?? '',
      tanggalKembali: map['tanggalKembali'] ?? '',
      requestStatus: map['requestStatus'] ?? 'pending',
      returnCode: map['returnCode'],
      returnDate: map['returnDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'borrowCode': borrowCode,
      'uid': uid,
      // user model
      'nama': nama,
      'email': email,
      'kelas': kelas,
      'kontak': kontak,
      // book model
      'bookId': bookId,
      'judulBuku': judulBuku,
      'penulis': penulis,
      'tahun': tahun,
      'penerbit': penerbit,
      'category': category,
      'image': image,
      'isbn': isbn,
      'jumlahHalaman': jumlahHalaman,
      'bahasa': bahasa,
      'lokasiRak': lokasiRak,
      // for loan
      'tanggalPinjam': tanggalPinjam,
      'tanggalKembali': tanggalKembali,
      'requestStatus': requestStatus,
      'returnCode': returnCode,
      'returnDate': returnDate,
    };
  }

  // loan copy for update request
  LoanRequest copyWith({
    String? id,
    String? requestStatus,
    String? returnCode,
    String? returnDate,
  }) {
    return LoanRequest(
      id: id ?? this.id,
      borrowCode: borrowCode,
      uid: uid,
      nama: nama,
      email: email,
      kelas: kelas,
      kontak: kontak,
      bookId: bookId,
      judulBuku: judulBuku,
      tahun: tahun,
      penulis: penulis,
      penerbit: penerbit,
      category: category,
      image: image,
      isbn: isbn,
      jumlahHalaman: jumlahHalaman,
      bahasa: bahasa,
      lokasiRak: lokasiRak,
      tanggalPinjam: tanggalPinjam,
      tanggalKembali: tanggalKembali,
      requestStatus: requestStatus ?? this.requestStatus,
      returnCode: returnCode ?? this.returnCode,
      returnDate: returnDate ?? this.returnDate,
    );
  }

  factory LoanRequest.empty() {
    return LoanRequest(
      id: "",
      borrowCode: "",
      uid: "",
      nama: "",
      email: "",
      kelas: "",
      kontak: "",
      bookId: "",
      judulBuku: "",
      tahun: "",
      penulis: "",
      penerbit: "",
      category: "",
      image: "",
      isbn: "",
      jumlahHalaman: 0,
      bahasa: "",
      lokasiRak: "",
      tanggalPinjam: "",
      tanggalKembali: "",
      requestStatus: "",
      returnCode: "",
      returnDate: "",
    );
  }
}
