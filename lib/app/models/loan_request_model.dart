class LoanRequestModel {
  final String id;
  final String borrowCode;
  final String userId;
  final String bookId;
  final DateTime tanggalPinjam;
  final DateTime tanggalKembali;
  final String requestStatus;
  final String? returnCode;
  final DateTime? returnDate;
  final DateTime? createdAt;

  LoanRequestModel({
    required this.id,
    required this.borrowCode,
    required this.userId,
    required this.bookId,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.requestStatus,
    this.returnCode,
    this.returnDate,
    this.createdAt,
  });

  factory LoanRequestModel.fromMap(Map<String, dynamic> map) {
    return LoanRequestModel(
      id: map['id'],
      borrowCode: map['borrow_code'],
      userId: map['user_id'],
      bookId: map['book_id'],
      tanggalPinjam: DateTime.parse(map['tanggal_pinjam']),
      tanggalKembali: DateTime.parse(map['tanggal_kembali']),
      requestStatus: map['request_status'],
      returnCode: map['return_code'],
      returnDate: map['return_date'] != null
          ? DateTime.parse(map['return_date'])
          : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'borrow_code': borrowCode,
      'user_id': userId,
      'book_id': bookId,
      'tanggal_pinjam': tanggalPinjam.toIso8601String(),
      'tanggal_kembali': tanggalKembali.toIso8601String(),
      'request_status': requestStatus,
      'return_code': returnCode,
      'return_date': returnDate?.toIso8601String(),
      // created_at otomatis oleh Supabase
    };
  }

  LoanRequestModel copyWith({
    String? id,
    String? borrowCode,
    String? userId,
    String? bookId,
    DateTime? tanggalPinjam,
    DateTime? tanggalKembali,
    String? requestStatus,
    String? returnCode,
    DateTime? returnDate,
    DateTime? createdAt,
  }) {
    return LoanRequestModel(
      id: id ?? this.id,
      borrowCode: borrowCode ?? this.borrowCode,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      tanggalPinjam: tanggalPinjam ?? this.tanggalPinjam,
      tanggalKembali: tanggalKembali ?? this.tanggalKembali,
      requestStatus: requestStatus ?? this.requestStatus,
      returnCode: returnCode ?? this.returnCode,
      returnDate: returnDate ?? this.returnDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
