import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();

  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  Rx<User?> firebaseUser = Rx<User?>(auth.currentUser);

  User? get user => firebaseUser.value;
  String? get userEmail => user?.email;

  @override
  void onInit() {
    super.onInit();
    // listening auth state changes
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _handleAuthChanged); // setiap user berubah
  }

  void _handleAuthChanged(User? user) async {
    if (user != null) {
      isLoggedIn.value = true;
      // optional: simpan user data dari firestore ke local storage
      await loadUserData();
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    if (user == null) return null;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (!snap.exists) return null;

    return snap.data() as Map<String, dynamic>;
  }

  Future<void> loadUserData() async {
    if (user == null) return;
    isLoading.value = true;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        box.write('name', data['name']);
        box.write('email', data['email']);
        box.write('id', data['id']);
      }
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value = userCredential.user;

      // ambil data user
      await loadUserData();

      Get.snackbar('Success', 'Login berhasil',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed('/layout'); // masuk layout/home
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Terjadi kesalahan',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Register method
  Future<void> register(String email, String password, String name) async {
    isLoading.value = true;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'id': credential.user!.uid,
        'name': name,
        'email': email,
        'role': 'User',
        'timestamp': Timestamp.now(),
      });

      Get.snackbar('Success', 'Akun berhasil dibuat! Silakan login.',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'weak-password') message = 'Password terlalu lemah';
      if (e.code == 'email-already-in-use') message = 'Email sudah terdaftar';
      Get.snackbar('Error', message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await auth.signOut();
    box.erase();
    firebaseUser.value = null;
    Get.snackbar('Success', 'Logout berhasil',
        backgroundColor: Colors.green, colorText: Colors.white);
    Get.offAllNamed('/welcome');
  }

  // Reset password
  Future<void> sendPasswordResetEmail(String email) async {
    isLoading.value = true;
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent',
          backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
