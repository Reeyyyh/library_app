import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/update_user_controller.dart';

class UpdateUserView extends GetView<UpdateUserController> {
  const UpdateUserView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(UpdateUserController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Update User'),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Center(
              child: Image.asset(
                'assets/user.png',
                height: 150,
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
              labelText: 'Email',
              controller: controller.emailController,
              errorMessage: controller.emailError.value,
              readonly: true,
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
