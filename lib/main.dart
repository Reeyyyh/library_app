import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/screen/controllers/splash_controller.dart';
import 'package:library_app/app/modules/screen/splash_view.dart';

void main(List<String> args) {
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Library_app",
      home: SplashView(),
      initialBinding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
  );
}