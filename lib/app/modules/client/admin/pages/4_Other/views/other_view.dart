import 'package:flutter/material.dart';
import 'package:library_app/app/modules/client/admin/widgets/admin_appbar.dart';

// Halaman "Lainnya" untuk menu admin
class Other extends StatelessWidget {
  const Other({super.key});
// Build method untuk membangun tampilan halaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar custom untuk admin
      appBar: AdminAppBar(
        title: "Lainnya",
        showBack: false,
      ),

      // Konten utama halaman
      body: Center(
        child: Text(
          'Other Page', // Placeholder tampilan
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
