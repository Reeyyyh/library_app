import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/create_faq_controller.dart';

class CreateFaqView extends GetView<CreateFaqController> {
  const CreateFaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tambah FAQ'),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Text(
              'Tambah FAQ',
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
                    'Silahkan isi form di bawah ini untuk menambahkan FAQ',
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomInput(
              labelText: 'Pertanyaan',
              controller: controller.judulController,
              errorMessage: controller.judulError.value,
            ),
            const SizedBox(height: 14),
            CustomInput(
              labelText: 'Jawaban',
              controller: controller.deskripsiController,
              errorMessage: controller.deskripsiError.value,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Submit',
              onPressed: controller.onSubmit,
              isLoading: controller.isLoading.value,
            )
          ],
        ),
      ),
    );
  }
}
