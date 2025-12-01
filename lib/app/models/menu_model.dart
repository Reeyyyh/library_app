import 'package:flutter/material.dart';

class Menu {
  final String title;     
  final int count;
  final String unit;
  final IconData icon;

  Menu({
    required this.title,
    required this.count,
    required this.unit,
    required this.icon,
  });

  Menu copyWith({
    String? title,
    int? count,
    String? unit,
    IconData? icon,
  }) {
    return Menu(
      title: title ?? this.title,
      count: count ?? this.count,
      unit: unit ?? this.unit,
      icon: icon ?? this.icon,
    );
  }

  // 🔽 Tambahan 1 — Convert ke Map (untuk database atau local storage)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'count': count,
      'unit': unit,
      'icon': icon.codePoint, // icon disimpan sebagai codePoint
    };
  }

  // 🔽 Tambahan 2 — Convert dari Map
  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      title: map['title'],
      count: map['count'],
      unit: map['unit'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  // 🔽 Tambahan 3 — Convert ke JSON
  String toJson() => toMap().toString();

  // 🔽 Tambahan 4 — Debug print yang lebih rapi
  @override
  String toString() {
    return 'Menu(title: $title, count: $count, unit: $unit, icon: $icon)';
  }
}
// merge