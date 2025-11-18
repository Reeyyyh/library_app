import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:library_app/app/controllers/auth_controller.dart';

class HomeController extends GetxController {
  RxString name = ''.obs;
  RxString imageUrl = ''.obs;
  GetStorage box = GetStorage();

  var categories = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  final authC = Get.find<AuthController>();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    getCategories();
  }

  // Cek apakah user login, kalau tidak langsung logout
  void checkLogin() async {
    if (authC.user == null || box.read('id') == null) {
      authC.logout();
    } else {
      await getUserData();
    }
  }

  // Ambil data user berdasarkan UID
  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      String? uid = authC.user?.uid;
      if (uid != null) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>;
          name.value = data['name'] ?? 'No Name';
          imageUrl.value = data['image'] ?? ''; // default kosong jika tidak ada
          // Simpan ke GetStorage agar bisa dipakai di HomePage
          box.write('name', name.value);
          box.write('image', imageUrl.value);
        } else {
          authC.logout();
        }
      } else {
        authC.logout();
      }
    } catch (e) {
      print('Error fetching user data: $e');
      authC.logout();
    } finally {
      isLoading.value = false;
    }
  }

  // Ambil kategori
  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .limit(4)
          .get();
      categories.value = snapshot.docs
          .map((e) => {
                'id': e.id,
                ...e.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
