import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      body: Column(
        children: [
          _buildHeader(context, controller),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildAccountInfo(controller),
                  const SizedBox(height: 20),
                  _buildStudentInfo(controller),
                  const SizedBox(height: 30),
                  _editButton(),
                  const SizedBox(height: 20),
                  _logoutButton(controller),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// HEADER + AVATAR
  Widget _buildHeader(BuildContext context, ProfileController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7BD99E),
            Color(0xFF4AB57B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
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
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 55, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 14),

          /// Reactive Name & Email
          Obx(() => Column(
                children: [
                  Text(
                    controller.name.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.email.value,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /// ACCOUNT INFO CARD
  Widget _buildAccountInfo(ProfileController c) {
    return _infoCard(
      title: "Informasi Akun",
      children: [
        _infoRow("Nama", c.name),
        _infoRow("Email", c.email),
      ],
    );
  }

  /// STUDENT INFO CARD
  Widget _buildStudentInfo(ProfileController c) {
    return _infoCard(
      title: "Detail Siswa",
      children: [
        _infoRow("Kelas", c.kelas),
        _infoRow("Kontak", c.kontak),
      ],
    );
  }

  /// UNIVERSAL CARD WRAPPER
  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  /// SINGLE ROW
  Widget _infoRow(String label, RxString value) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value.value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(color: Colors.grey[300]),
            ],
          ),
        ));
  }

  /// EDIT BUTTON
  Widget _editButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green.withOpacity(0.1),
          foregroundColor: Colors.green[900],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
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
    );
  }

  /// LOGOUT BUTTON
  Widget _logoutButton(ProfileController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => controller.logout(),
        child: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
