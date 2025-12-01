import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/pages/4_Profile/views/edit_profile_view.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: CustomAppBar(title: 'Profile'),
      body: Obx(() {
        final user = controller.auth.userModel.value;

        // Jika user masih null (sedang load), tampilkan loading
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const SizedBox(height: 24),

            // Avatar user
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: user.image.isNotEmpty
                  ? NetworkImage(user.image)
                  : null,
              child: user.image.isEmpty
                  ? const Icon(Icons.person, size: 56, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 24),

            // Card informasi user
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _profileRow(label: 'Nama', value: user.name),
                        const Divider(height: 24),
                        _profileRow(label: 'Email', value: user.email),
                        const Divider(height: 24),
                        _profileRow(
                          label: 'Kelas',
                          value: user.kelas.isEmpty ? '-' : user.kelas,
                        ),
                        const Divider(height: 24),
                        _profileRow(
                          label: 'Kontak',
                          value: user.kontak.isEmpty ? '-' : user.kontak,
                        ),
                      ],
                    ),

                    // Tombol Edit
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
                          Get.to(() => const EditProfileView());
                        },
                        icon: const Icon(Icons.edit, size: 16),
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

            const SizedBox(height: 24),

            // Tombol logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => controller.logout(),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        );
      }),
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
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
// merge