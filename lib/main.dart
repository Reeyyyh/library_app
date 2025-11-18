import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:library_app/app/constants/config.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/controllers/auth_controller.dart';
import 'package:library_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Supabase
  await supa.Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseKey,
  );

  // GetStorage
  await GetStorage.init();

  // AuthController permanent
  Get.put(AuthController(), permanent: true);

  runApp(const MyApp());
}
// sfsasaf
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    // Pastikan firebaseUser ada di AuthController
    authC.firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    return Obx(() {
      // Cek apakah user sudah login
      bool isLoggedIn = authC.firebaseUser.value != null;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Library App",
        initialRoute: isLoggedIn ? '/layout' : '/welcome',
        getPages: AppPages.routes,
        theme: ThemeData(
          colorSchemeSeed: AppTheme.primaryColor,
          scaffoldBackgroundColor: AppTheme.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppTheme.backgroundColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      );
    });
  }
}
