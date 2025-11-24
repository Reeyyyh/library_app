import 'package:flutter/material.dart';

// Model untuk item menu pada dashboard
class Menu {
  final String title;     // Nama menu
  final int count;        // Jumlah atau angka yang ditampilkan
  final String unit;      // Satuan dari angka (mis: "buku", "item")
  final IconData icon;    // Ikon menu

  // Konstruktor utama
  Menu({
    required this.title,
    required this.count,
    required this.unit,
    required this.icon,
  });

  // Membuat salinan Menu dengan nilai yang dapat diubah sebagian
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
}
