import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.user.value; // <-- perbaikan utama

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/edit-profile');
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.edit, color: Colors.black),
                        const SizedBox(width: 5),
                        Text(
                          'Edit Profil',
                          style: AppTheme.heading2.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ======================= FOTO PROFIL =======================
              data == null || data['image'] == null
                  ? CircleAvatar(
                      radius: 75,
                      backgroundColor: AppTheme.primaryColor,
                      child: Text(
                        data == null
                            ? '-'
                            : (data['name']?[0].toUpperCase() ?? '-'),
                        style: AppTheme.heading1.copyWith(
                          fontSize: 52,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        data['image'],
                      ),
                    ),

              const SizedBox(height: 20),

              // ======================= DETAIL PROFIL =======================
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Nama',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data?['name'] ?? '-',
                        style: AppTheme.heading3.copyWith(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Email',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data?['email'] ?? '-',
                        style: AppTheme.heading3.copyWith(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Kelas',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data?['kelas'] ?? '-',
                        style: AppTheme.heading3.copyWith(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Kontak',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data?['kontak'] ?? '-',
                        style: AppTheme.heading3.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
