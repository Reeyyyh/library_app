class CategoryModel {
  final String id;
  final String name;
  final int position;
  final DateTime? createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.position,
    this.createdAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      position: map['position'] ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
    };
  }
}
