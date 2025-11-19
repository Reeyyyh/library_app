import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/client/users/botnav/controllers/user_botnav_controller.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class UserBotNavView extends StatelessWidget {
  const UserBotNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserBotNavController());
    return Scaffold(
      body: Obx(() => _body(controller, controller.selectedIndex.value)),
      bottomNavigationBar: _bottomNavigationBar(controller),
    );
  }

  Widget _body(UserBotNavController controller, int index) {
    return controller.menus[index]['page'];
  }

  Widget _bottomNavigationBar(UserBotNavController controller) {
    return Obx(
      () => Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
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
                          ? CustomAppTheme.primaryColor
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
                    style: CustomAppTheme.caption.copyWith(
                      color: controller.selectedIndex.value == index
                          ? CustomAppTheme.primaryColor
                          : Colors.black,
                      fontWeight: controller.selectedIndex.value == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
