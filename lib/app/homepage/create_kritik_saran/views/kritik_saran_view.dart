import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/custom_input.dart';

import '../controllers/create_kritik_saran_controller.dart';

class CreateKritikSaranView extends GetView<CreateKritikSaranController> {
  const CreateKritikSaranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Buat Kritik & Saran'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        children: [
          Text(
            'Silahkan isi formulir berikut untuk memberikan kritik dan saran.',
            style: AppTheme.heading2.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInput(
                  labelText: 'Kritik',
                  controller: controller.kritikController,
                  errorMessage: controller.kritikError.value,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                CustomInput(
                  labelText: 'Saran',
                  controller: controller.saranController,
                  errorMessage: controller.saranError.value,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Submit',
                  onPressed: controller.onSubmit,
                  isLoading: controller.isLoading.value,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
// End of File
