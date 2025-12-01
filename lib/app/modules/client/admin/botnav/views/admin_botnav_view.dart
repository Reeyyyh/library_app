import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/admin/botnav/controllers/admin_botnav_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class AdminBotNavView extends StatelessWidget {
  const AdminBotNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminBotnavController());

    return Scaffold(
      body: Obx(() => controller.menus[controller.selectedIndex.value]['page']),
      bottomNavigationBar: Obx(
        () => Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              controller.menus.length,
              (index) => GestureDetector(
                onTap: () => controller.changeTabIndex(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? CustomAppTheme.primaryColor // atau AppTheme.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        controller.menus[index]['icon'],
                        color: controller.selectedIndex.value == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      controller.menus[index]['title'],
                      style: TextStyle(
                        fontWeight: controller.selectedIndex.value == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.selectedIndex.value == index
                            ? CustomAppTheme.primaryColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// merge