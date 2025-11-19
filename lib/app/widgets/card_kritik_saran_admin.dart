import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/theme.dart';
import 'package:library_app/app/widgets/dateformat.dart';

class CardKritikSaranAdmin extends StatelessWidget {
  const CardKritikSaranAdmin({
    super.key,
    required this.userData,
    required this.item,
  });

  final Map<String, dynamic> userData;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Nama : ',
                style: AppTheme.heading2.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                userData['name'],
                style: AppTheme.heading3.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tanggal : ',
                style: AppTheme.heading2.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                dateFormat(item['created_at']),
                style: AppTheme.heading3.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(),
          const SizedBox(height: 5),
          Text(
            'Kritik',
            style: AppTheme.heading2.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            item['kritik'],
            style: AppTheme.heading3.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Saran',
            style: AppTheme.heading2.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            item['saran'],
            style: AppTheme.heading3.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
