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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            controller.menus.length,
            (index) {
              final bool isSelected =
                  controller.selectedIndex.value == index;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => controller.changeTabIndex(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? CustomAppTheme.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Icon(
                            controller.menus[index]['icon'],
                            size: 22,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.menus[index]['title'],
                          style: CustomAppTheme.caption.copyWith(
                            fontSize: 11,
                            color: isSelected
                                ? CustomAppTheme.primaryColor
                                : Colors.grey[600],
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
