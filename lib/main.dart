import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/screen/controllers/splash_controller.dart';
import 'package:library_app/app/modules/screen/splash_view.dart';

Future<void> main(List<String> args) async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthService(), permanent: true);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Library_app",
      home: SplashView(),
      initialBinding: BindingsBuilder(
        () {
          Get.put(SplashController());
        },
      ),
    ),
  );
}
// marge