import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_input.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: CustomAppTheme.backgroundColor,
      appBar: const CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // ===========================
            // FOTO PROFILE
            // ===========================
            Obx(() {
              final user = controller.auth.userModel.value;

              return CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: (user?.image != null && user!.image.isNotEmpty)
                    ? NetworkImage(user.image)
                    : null,
                child: (user?.image == null || user!.image.isEmpty)
                    ? const Icon(Icons.person, size: 56, color: Colors.white)
                    : null,
              );
            }),

            const SizedBox(height: 30),

            // ===========================
            // FORM INPUT
            // ===========================

            CustomInput(
              labelText: "Nama",
              controller: controller.nameC,
              hintText: "Masukkan nama lengkap",
            ),
            const SizedBox(height: 20),

            CustomInput(
              labelText: "Email",
              controller: controller.emailC,
              hintText: "Email tidak dapat diedit",
              readonly: true,
            ),
            const SizedBox(height: 20),

            CustomInput(
              labelText: "Kelas",
              controller: controller.kelasC,
              hintText: "Masukkan kelas",
            ),
            const SizedBox(height: 20),

            CustomInput(
              labelText: "Kontak",
              controller: controller.kontakC,
              hintText: "Masukkan nomor HP",
              isNumber: true,   // 👈 sesuai permintaan
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            // ===========================
            // BUTTON SIMPAN
            // ===========================
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => controller.updateProfile(),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
