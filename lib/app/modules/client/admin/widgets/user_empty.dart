import 'package:flutter/material.dart';

class EmptyUserCard extends StatelessWidget {
  const EmptyUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.people_outline,
                size: 52,
                color: Colors.blueGrey[300],
              ),
              const SizedBox(height: 14),
              Text(
                "Belum ada pengguna",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey[700],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Pengguna dengan role 'user' akan muncul di sini.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
