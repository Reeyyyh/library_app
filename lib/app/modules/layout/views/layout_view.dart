import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';

import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LayoutController());
    return Scaffold(
      body: Obx(
        () => _body(controller.selectedIndex.value),
      ),
      bottomNavigationBar: _bottomNavigationbar(),
    );
  }

  Widget _body(int index) {
    return controller.menus[index]['page'];
  }

  Widget _bottomNavigationbar() {
    return Obx(
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
                          ? AppTheme.primaryColor
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
                    style: AppTheme.caption.copyWith(
                      color: controller.selectedIndex.value == index
                          ? AppTheme.primaryColor
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
