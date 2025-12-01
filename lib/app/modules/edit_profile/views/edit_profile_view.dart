import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Update Profile'),
      body: Obx(
        () => controller.isFetching.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  Center(
                    child: Stack(
                      children: [
                        controller.imagePath.value.isNotEmpty
                            ? CircleAvatar(
                                radius: 75,
                                backgroundImage: FileImage(
                                  File(controller.imagePath.value),
                                ),
                              )
                            : controller.imageUrl.value.isNotEmpty
                                ? CircleAvatar(
                                    radius: 75,
                                    backgroundImage: NetworkImage(
                                      controller.imageUrl.value,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 75,
                                    backgroundColor: AppTheme.primaryColor,
                                    child: Text(
                                      controller.nameController.text[0]
                                          .toUpperCase(),
                                      style: AppTheme.heading1.copyWith(
                                        fontSize: 52,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text(
                                            'Pick Image from Gallery'),
                                        onTap: () {
                                          controller
                                              .pickMedia(ImageSource.gallery);
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: const Text(
                                            'Pick Image from Camera'),
                                        onTap: () {
                                          controller
                                              .pickMedia(ImageSource.camera);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomInput(
                    labelText: 'Nama',
                    controller: controller.nameController,
                    errorMessage: controller.nameError.value,
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    labelText: 'Kelas',
                    controller: controller.kelasController,
                    errorMessage: controller.kelasError.value,
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    labelText: 'Kontak',
                    controller: controller.kontakController,
                    errorMessage: controller.kontakError.value,
                    isNumber: true,
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    labelText: 'Alamat',
                    controller: controller.alamatController,
                    errorMessage: controller.alamatError.value,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Save',
                    onPressed: controller.onSubmit,
                    isLoading: controller.isLoading.value,
                  )
                ],
              ),
      ),
    );
  }
}
