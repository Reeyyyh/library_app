import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_app/app/models/user_model.dart';

class AdminUserManagementController extends GetxController {
  final supabase = Supabase.instance.client;

  final isLoading = true.obs;
  final users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;

      final data = await supabase
          .from('users')
          .select()
          .eq('role', 'user')
          .order('created_at', ascending: false);

      users.value =
          data.map<UserModel>((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengambil data pengguna",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleUserStatus(UserModel user) async {
    try {
      await supabase.from('users').update({
        'is_active': !user.isActive,
      }).eq('id', user.id);

      // update lokal biar UI langsung berubah
      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = user.copyWith(isActive: !user.isActive);
      }

      Get.snackbar(
        "Berhasil",
        user.isActive
            ? "Akun berhasil dinonaktifkan"
            : "Akun berhasil diaktifkan",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal mengubah status akun");
    }
  }
}
