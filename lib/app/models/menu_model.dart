import 'package:flutter/material.dart';

class Menu {
  final String title;
  final int count;
  final String unit;
  final IconData icon;

  Menu({required this.title, required this.count, required this.unit, required this.icon});

  Menu copyWith({String? title, int? count, String? unit, IconData? icon}) {
    return Menu(
      title: title ?? this.title,
      count: count ?? this.count,
      unit: unit ?? this.unit,
      icon: icon ?? this.icon,
    );
  }
}