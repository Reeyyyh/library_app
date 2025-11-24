import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/user_model.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();

    firebaseUser.bindStream(_auth.authStateChanges());

    ever(firebaseUser, (user) async {
      if (user != null) {
        await fetchUserData(user.uid);
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
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      UserModel user = UserModel(
        uid: uid,
        name: name,
        email: email,
        kelas: "",
        kontak: "",
        role: "user",
        isActive: true,
        image: '',
        createdAt: DateTime.now(), 
      );

      await _firestore.collection("users").doc(uid).set(user.toMap());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Terjadi kesalahan";
    }
  }

  // LOGIN
  Future<String?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("users").doc(uid).get();

      if (!snap.exists) {
        await _auth.signOut();
        return "User tidak ditemukan";
      }

      bool isActive = snap.data()?["is_active"] ?? false;

      if (!isActive) {
        await _auth.signOut();
        return "Akun Anda dinonaktifkan oleh admin";
      }

      userModel.value = UserModel.fromMap(snap.data()!);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Terjadi kesalahan";
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // FETCH USER
  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection("users").doc(uid).get();

    if (snap.exists) {
      userModel.value = UserModel.fromMap(snap.data()!);
    }
  }
}

// ------------------------------------------------------------
// Commit: Fix - corrected user_model import and adjusted 
// authStateChanges binding
//
// Description:
// - Updated the import path for user_model to the correct location.
// - Adjusted the binding logic for authStateChanges to ensure
//   real-time authentication status updates.
// - Cleaned up and improved readability for the AuthService class.
//
// This comment is added for documentation and commit tracking.
// ------------------------------------------------------------
