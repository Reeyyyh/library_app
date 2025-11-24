import 'package:cloud_firestore/cloud_firestore.dart';

/// Model data untuk merepresentasikan user yang tersimpan di Firestore.
/// 
/// Field–field di dalam class ini harus konsisten dengan struktur dokumen
/// collection user di Firestore (nama field, tipe data, dsb).
class UserModel {
  /// UID unik user (biasanya dari Firebase Auth).
  final String uid;

  /// Nama lengkap user.
  final String name;

  /// Alamat email user.
  final String email;

  /// Kelas user (misal: "TI 2022", "5A", dll).
  final String kelas;

  /// Kontak user (bisa nomor WhatsApp / HP).
  final String kontak;

  /// Role user dalam aplikasi (misal: "admin", "user").
  final String role;

  /// Menandakan apakah user masih aktif atau tidak.
  final bool isActive;

  /// URL foto profil user yang tersimpan di storage.
  final String image; // ← ADD

  /// Tanggal dan waktu ketika user dibuat di Firestore.
  final DateTime? createdAt;

  /// Constructor utama untuk membuat instance [UserModel] secara manual.
  ///
  /// Biasanya digunakan ketika akan menyimpan data baru ke Firestore.
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.kelas,
    required this.kontak,
    required this.role,
    required this.isActive,
    required this.image, // ← ADD
    this.createdAt,
  });

  /// Factory constructor untuk membuat [UserModel] dari [Map] (misal dari Firestore).
  ///
  /// - [map] biasanya berasal dari `DocumentSnapshot.data()` yang sudah di-cast ke
  ///   `Map<String, dynamic>`.
  /// - Pastikan key pada [map] sesuai dengan nama field di Firestore.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      kelas: map['kelas'] ?? '',
      kontak: map['kontak'] ?? '',
      role: map['role'] ?? 'user',
      isActive: map['is_active'] ?? true,
      image: map['image'] ?? '', // ← ADD
      // `created_at` disimpan sebagai Timestamp di Firestore,
      // lalu dikonversi ke DateTime di sisi aplikasi.
      createdAt: (map['created_at'] as Timestamp?)?.toDate(),
    );
  }

  /// Mengubah [UserModel] menjadi [Map] agar bisa disimpan ke Firestore.
  ///
  /// Biasanya digunakan saat:
  /// - menambah dokumen baru: `collection.doc(uid).set(user.toMap());`
  /// - mengupdate dokumen: `collection.doc(uid).update(user.toMap());`
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "kelas": kelas,
      "kontak": kontak,
      "role": role,
      "is_active": isActive,
      "image": image, // ← ADD
      // Jika `createdAt` null, Firestore tetap akan menyimpan null, 
      // atau bisa diganti dengan FieldValue.serverTimestamp() di layer service.
      "created_at": createdAt,
    };
  }
}
