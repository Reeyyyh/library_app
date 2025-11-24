import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // pakai Get.put biar controller ke-register
    final controller = Get.put(ProfileController());

    return Scaffold(
      // background hijau muda biar soft kaya UI contoh
      backgroundColor: const Color(0xFFE8F7E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F7E9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),

          // Avatar user
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(
              Icons.person,
              size: 56,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Card data profile
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileRow(
                    label: 'Nama',
                    value: 'Rakabima', // sementara dummy
                  ),
                  const Divider(height: 24),
                  _profileRow(
                    label: 'Email',
                    value: 'rakabima@perpustakaan.com',
                  ),
                  const Divider(height: 24),
                  _profileRow(
                    label: 'Kelas',
                    value: 'XI A',
                  ),
                  const Divider(height: 24),
                  _profileRow(
                    label: 'Kontak',
                    value: '+62 812 3456 7890',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Tombol Edit (kuning)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC400), // kuning
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 2,
            ),
            onPressed: () {
              // nanti bisa diarahkan ke EditProfileView
              Get.snackbar(
                'Info',
                'Fitur edit profile belum diimplementasikan',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text(
              'Edit',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          const Spacer(),

          // Tombol logout di bawah
          TextButton(
            onPressed: () {
              controller.logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _profileRow({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
