import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/models/menu_model.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  RxString name = 'Admin'.obs;
  RxBool isLoading = false.obs;

  RxList<Menu> menus = <Menu>[
    Menu(title: 'Buku', count: 0, unit: 'Buah', icon: Icons.book_outlined),
    Menu(
        title: 'Kategori',
        count: 0,
        unit: 'Jenis',
        icon: Icons.category_outlined),
    Menu(title: 'Riwayat', count: 0, unit: 'Data', icon: Icons.history_rounded),
    Menu(
        title: 'Pengguna',
        count: 0,
        unit: 'Orang',
        icon: Icons.person_outline_rounded),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // listen real-time untuk semua collection
    _listenCollectionCount('books', 0);
    _listenCollectionCount('categories', 1);
    _listenCollectionCount('history', 2);
    _listenCollectionCount('users', 3);

    fetchLoanRequests();
  }

  void _listenCollectionCount(String collection, int index) {
    FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .listen((snap) {
      menus[index] = menus[index].copyWith(count: snap.docs.length);
      menus.refresh();
    });
  }

  RxList<LoanRequest> loanRequests = <LoanRequest>[].obs;

  Future<void> fetchLoanRequests() async {
    try {
      isLoading.value = true;

      final snapshot = await FirebaseFirestore.instance
          .collection('loan_requests')
          .orderBy('tanggalPinjam', descending: true)
          .get();

      loanRequests.value =
          snapshot.docs.map((doc) => LoanRequest.fromMap(doc.data())).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data pengajuan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    // nanti isi logic refresh di sini
  }

  Future<void> logout() async {
    try {
      await auth.logout();
      Get.snackbar(
        "Sukses",
        "Logout berhasil",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal logout: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
