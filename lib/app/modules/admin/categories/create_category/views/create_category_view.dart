import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/create_category_controller.dart';

class CreateCategoryView extends GetView<CreateCategoryController> {
  const CreateCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tambah Kategori'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Tambah Kategori Baru',
            style: AppTheme.heading2.copyWith(
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  'Silahkan isi form di bawah ini untuk menambahkan kategori baru',
                  style: AppTheme.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomInput(
              labelText: 'Nama Kategori',
              controller: controller.nameController,
              errorMessage: controller.nameError.value,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => CustomButton(
              text: 'Save',
              onPressed: controller.onSubmit,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
