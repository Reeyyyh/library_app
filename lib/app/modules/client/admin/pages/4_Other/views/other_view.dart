import 'package:flutter/material.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';

class Other extends StatelessWidget {
  const Other({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: "Kategori",
        showBack: false,
      ),
      body: Center(
        child: Text(
          'Other Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
