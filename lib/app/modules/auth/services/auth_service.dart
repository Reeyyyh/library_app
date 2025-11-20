import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable user
  Rx<User?> firebaseUser = Rx<User?>(null);

  // Observable user data (Firestore)
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen auth state
    firebaseUser.bindStream(_auth.authStateChanges());

    ever(firebaseUser, (user) async {
      if (user != null) {
        await fetchUserData(user.uid);
      } else {
        userData.clear();
      }
    });
  }

  // ===============================
  // REGISTER
  // ===============================
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = credential.user!.uid;

      await _firestore.collection("users").doc(uid).set({
        "uid": uid,
        "name": name,
        "email": email,
        "role": "user",
        "is_active": true,
        "created_at": FieldValue.serverTimestamp(),
      });

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Terjadi kesalahan";
    }
  }

  // ===============================
  // LOGIN
  // ===============================
  Future<String?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      DocumentSnapshot snap =
          await _firestore.collection("users").doc(uid).get();

      if (!snap.exists) {
        await _auth.signOut();
        return "User tidak ditemukan";
      }

      bool isActive = snap.get("is_active") ?? false;

      if (!isActive) {
        await _auth.signOut();
        return "Akun Anda dinonaktifkan oleh admin";
      }

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Terjadi kesalahan";
    }
  }

  // ===============================
  // LOGOUT
  // ===============================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ===============================
  // FETCH USER DATA
  // ===============================
  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection("users").doc(uid).get();

    if (snap.exists) {
      userData.assignAll(snap.data()!);
    }
  }
}
