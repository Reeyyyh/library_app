import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  // next job
  @override
  Widget build(BuildContext context) {
    // Registrasi ProfileController dengan GetX
    final controller = Get.put(ProfileController());

    return Scaffold(
      // Background hijau muda supaya soft seperti UI contoh
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

          // Avatar user di bagian atas
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
              child: Stack(
                children: [
                  // Isi teks profile
                  Column(
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

                  // Tombol Edit kecil di pojok kanan atas card
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange[800],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      onPressed: () {
                        // nanti bisa diarahkan ke EditProfileView
                        Get.snackbar(
                          'Info',
                          'Fitur edit profile belum diimplementasikan',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Tombol logout besar warna merah di bawah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  controller.logout();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Widget helper untuk 1 baris informasi profil (label + value).
  Widget _profileRow({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label abu-abu kecil
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        // Value utama
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
