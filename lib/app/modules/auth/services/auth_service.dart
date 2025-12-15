import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_app/app/models/user_model.dart';

class AuthService extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  Rx<Session?> session = Rx<Session?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();

    supabase.auth.onAuthStateChange.listen((event) async {
      final currentSession = event.session;
      session.value = currentSession;

      if (currentSession != null) {
        await fetchUserData(currentSession.user.id);
      } else {
        userModel.value = null;
      }
    });
  }

  // REGISTER
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final uid = res.user?.id;
      if (uid == null) {
        return "Registrasi gagal (UID null)";
      }

      await supabase.from("users").insert({
        "id": uid,
        "name": name,
        "email": email,
        "kelas": "",
        "kontak": "",
        "role": "user",
        "is_active": true,
        "image": "",
        "created_at": DateTime.now().toIso8601String(),
      });

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Terjadi error saat register";
    }
  }

  // LOGIN
  Future<String?> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final uid = res.user?.id;
      if (uid == null) {
        return "Login gagal (UID null)";
      }

      await fetchUserData(uid);

      return null; // sukses
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Terjadi error saat login";
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // FETCH USER DATA
  Future<void> fetchUserData(String uid) async {
    try {
      final data =
          await supabase.from("users").select().eq("id", uid).maybeSingle();
      print("DEBUG fetchUserData: $data");

      if (data != null) {
        userModel.value = UserModel.fromMap(data);
        print("DEBUG userModel: ${userModel.value?.role}");
      }
    } catch (e) {
      print("ERROR fetchUserData: $e");
    }
  }
}
