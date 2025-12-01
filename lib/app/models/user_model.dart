import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String kelas;
  final String kontak;
  final String role;
  final bool isActive;
  final String image;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.kelas,
    required this.kontak,
    required this.role,
    required this.isActive,
    required this.image,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      kelas: map['kelas'] ?? '',
      kontak: map['kontak'] ?? '',
      role: map['role'] ?? 'user',
      isActive: map['is_active'] ?? true,
      image: map['image'] ?? '',
      createdAt: (map['created_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "kelas": kelas,
      "kontak": kontak,
      "role": role,
      "is_active": isActive,
      "image": image,
      "created_at": createdAt,
    };
  }
}
// merge