import 'package:flutter/material.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';

class ListBook extends StatelessWidget {
  const ListBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Buku",
      ),
      body: Center(
        child: Text(
          'List Book Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
