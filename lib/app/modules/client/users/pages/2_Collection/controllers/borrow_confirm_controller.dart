import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
// Controller untuk mengelola konfirmasi peminjaman buku
class BorrowConfirmController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  var borrowDate = DateTime.now().obs;
  var duration = 7.obs;
  var userName = ''.obs;
// Inisialisasi controller dan memuat data pengguna saat controller dibuat
  @override
  void onInit() {
    super.onInit();
    userName.value = authService.userModel.value?.name ?? "Pengguna";
    ever(authService.userModel, (user) {
      userName.value = user?.name ?? "Pengguna";
    });
  }

  void setBorrowDate(DateTime date) {
    final today = DateTime.now();
    if (date.isBefore(DateTime(today.year, today.month, today.day))) {
      Get.snackbar("Error", "Tanggal pinjam tidak boleh di masa lalu",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    borrowDate.value = date;
  }

  void setReturnDate(DateTime date) {
    if (!date.isAfter(borrowDate.value)) {
      Get.snackbar("Error", "Tanggal kembali harus lebih dari tanggal pinjam",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    duration.value = date.difference(borrowDate.value).inDays;
  }

  String generateBorrowCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (i) => chars[Random().nextInt(chars.length)])
        .join();
  }

  Future<void> submitBorrow(LoanRequest request) async {
    try {
      await FirebaseFirestore.instance
          .collection("borrow_requests")
          .add(request.toMap());

      Get.snackbar(
        "Sukses",
        "Pengajuan peminjaman berhasil dikirim",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengirim peminjaman: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
