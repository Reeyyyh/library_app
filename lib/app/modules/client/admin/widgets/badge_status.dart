import 'package:flutter/material.dart';
import 'package:library_app/app/constants/theme.dart';

class BadgeStatus extends StatelessWidget {
  final String status;

  const BadgeStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Pending':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'Dipinjam':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      case 'Dikembalikan':
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        break;
      case 'Selesai':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.black.withOpacity(0.1);
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: AppTheme.heading1.copyWith(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
