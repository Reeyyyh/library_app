import 'package:flutter/material.dart';

class buildRating extends StatelessWidget {
  const buildRating({
    super.key,
    required this.rating,
    this.size = 20,
  });

  final int rating;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
          size: size.toDouble(),
        ),
      ),
    );
  }
}
