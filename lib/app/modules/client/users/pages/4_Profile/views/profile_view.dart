import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4),
      body: Stack(
        children: [
          // HEADER GRADIENT
          Container(
            height: 230,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7BD99E),
                  Color(0xFF4AB57B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // CURVED WHITE CONTAINER
          Positioned(
            top: 190,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F9F4),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
            ),
          ),

          // MAIN CONTENT
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  /// AVATAR
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: CircleAvatar(
                              radius: 120,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, size: 150),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 3,
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// NAMA + EMAIL (Reactif)
                  Obx(() => Column(
                        children: [
                          Text(
                            controller.name.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.email.value,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      )),

                  const SizedBox(height: 32),

                  /// CARD PROFILE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildSectionTitle("Informasi Akun"),
                        const SizedBox(height: 12),
                        _infoCard([
                          _profileItem("Nama", controller.name),
                          _profileItem("Email", controller.email),
                        ]),

                        const SizedBox(height: 20),
                        _buildSectionTitle("Detail Siswa"),
                        const SizedBox(height: 12),
                        _infoCard([
                          _profileItem("Kelas", controller.kelas),
                          _profileItem("Kontak", controller.kontak),
                        ]),

                        const SizedBox(height: 20),

                        /// TOMBOL EDIT PROFIL
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.white.withOpacity(0.4),
                              foregroundColor: Colors.green[800],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Get.snackbar(
                                "Info",
                                "Edit Profil belum tersedia",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text(
                              "Edit Profil",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                        _logoutButton(controller),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  /// CARD WRAPPER
  Widget _infoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// SINGLE PROFILE ROW
  Widget _profileItem(String label, RxString value) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
              value.value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 28),
          ],
        ));
  }

  /// LOGOUT BUTTON
  Widget _logoutButton(ProfileController controller) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () => controller.logout(),
        child: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
