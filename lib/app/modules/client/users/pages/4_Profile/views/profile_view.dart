import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFE8F7E9), // hijau muda bg
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

          // Avatar
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
                  _profileRow(label: 'Nama', value: controller.name),
                  const Divider(height: 24),
                  _profileRow(label: 'Email', value: controller.email),
                  const Divider(height: 24),
                  _profileRow(label: 'Kelas', value: controller.className),
                  const Divider(height: 24),
                  _profileRow(label: 'Kontak', value: controller.phone),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 2,
            ),
            onPressed: () {
              Get.to(() => ());
            },
            icon: const Icon(Icons.edit),
            label: const Text(
              'Edit',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          const Spacer(),

          // Contoh tombol logout kecil di bawah (opsional)
          TextButton(
            onPressed: () => controller.logout(),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _profileRow({required String label, required String value}) {
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
