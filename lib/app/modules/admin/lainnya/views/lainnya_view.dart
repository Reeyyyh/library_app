import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/lainnya_controller.dart';

class LainnyaView extends GetView<LainnyaController> {
  const LainnyaView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LainnyaController());
    return Scaffold(
        appBar: CustomAppBar(title: 'Menu Lainnya'),
        body: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1,
          ),
          itemCount: controller.menus.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Get.toNamed(controller.menus[index]['route']),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    controller.menus[index]['icon'],
                    size: 70,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.menus[index]['title'],
                    style: AppTheme.heading2.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
