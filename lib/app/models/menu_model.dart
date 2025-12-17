import 'package:flutter/material.dart';

class Menu {
<<<<<<< HEAD
  final String title;     
=======
  final String title, unit;
>>>>>>> rakarajinibadah
  final int count;
  final IconData icon;

  Menu({
    required this.title,
    required this.count,
    required this.unit,
    required this.icon,
  });

  Menu copyWith({String? title, int? count, String? unit, IconData? icon}) =>
      Menu(
        title: title ?? this.title,
        count: count ?? this.count,
        unit: unit ?? this.unit,
        icon: icon ?? this.icon,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'count': count,
        'unit': unit,
        'icon': icon.codePoint,
      };

  factory Menu.fromMap(Map<String, dynamic> map) => Menu(
        title: map['title'],
        count: map['count'],
        unit: map['unit'],
        icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      );

  String toJson() => toMap().toString();

  @override
  String toString() =>
      'Menu(title: $title, count: $count, unit: $unit, icon: $icon)';
}
// merge