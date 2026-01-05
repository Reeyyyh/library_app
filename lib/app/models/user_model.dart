class UserModel {
  final String id;
  final String name;
  final String email;
  final String kelas;
  final String kontak;
  final String role;
  final bool isActive;
  final String image;
  final DateTime? createdAt;

  UserModel({
    required this.id,
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
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      kelas: map['kelas'] ?? '',
      kontak: map['kontak'] ?? '',
      role: map['role'] ?? 'user',
      isActive: map['is_active'] ?? true,
      image: map['image'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "kelas": kelas,
      "kontak": kontak,
      "role": role,
      "is_active": isActive,
      "image": image,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? kelas,
    String? kontak,
    String? role,
    bool? isActive,
    String? image,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      kelas: kelas ?? this.kelas,
      kontak: kontak ?? this.kontak,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
