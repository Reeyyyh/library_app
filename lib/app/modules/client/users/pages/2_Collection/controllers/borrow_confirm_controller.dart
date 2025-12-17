import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';

class BorrowConfirmController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===========================
  // Reactive Variables
  // ===========================
  var isLoading = false.obs;
  var borrowDate = DateTime.now().obs;
  var duration = 7.obs; // Default 7 hari
  var userName = ''.obs;

  // ===========================
  // Getters (Computed Properties)
  // ===========================
  // Otomatis menghitung tanggal kembali berdasarkan borrowDate + duration
  DateTime get returnDate =>
      borrowDate.value.add(Duration(days: duration.value));

  @override
  void onInit() {
    super.onInit();
    _syncUser();
  }

  // Sinkronisasi data user dari AuthService
  void _syncUser() {
    userName.value = _authService.userModel.value?.name ?? "Pengguna";

    // Dengarkan perubahan jika user logout/login ulang
    ever(_authService.userModel, (user) {
      userName.value = user?.name ?? "Pengguna";
    });
  }

  // ===========================
  // Logic Tanggal
  // ===========================
  void setBorrowDate(DateTime date) {
    // Normalisasi tanggal ke jam 00:00:00 untuk perbandingan yang adil
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(date.year, date.month, date.day);

    if (selectedDate.isBefore(today)) {
      _showSnackbar("Error", "Tanggal pinjam tidak boleh di masa lalu",
          isError: true);
      return;
    }

    borrowDate.value = date;
  }

  void setReturnDate(DateTime date) {
    // Pastikan tanggal kembali strictly setelah tanggal pinjam
    final selectedReturn = DateTime(date.year, date.month, date.day);
    final selectedBorrow = DateTime(
        borrowDate.value.year, borrowDate.value.month, borrowDate.value.day);

    if (!selectedReturn.isAfter(selectedBorrow)) {
      _showSnackbar("Error", "Tanggal kembali harus sesudah tanggal pinjam",
          isError: true);
      return;
    }

    // Hitung selisih hari
    duration.value = selectedReturn.difference(selectedBorrow).inDays;
  }

  // ===========================
  // Helper Methods
  // ===========================
  String generateBorrowCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (i) => chars[Random().nextInt(chars.length)])
        .join();
  }

  void _showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  // ===========================
  // Submit Logic
  // ===========================
  Future<void> submitBorrow(LoanRequest request) async {
    try {
      isLoading.value = true;

      // Opsional: Update data request dengan data terbaru dari controller
      // agar sinkron dengan yang dipilih di UI (jika model mendukung copyWith)
      // final finalRequest = request.copyWith(
      //   borrowDate: borrowDate.value,
      //   returnDate: returnDate,
      // );

      await _firestore
          .collection("borrow_requests")
          .add(request.toMap()); // Gunakan finalRequest jika diaktifkan

      _showSnackbar("Sukses", "Pengajuan peminjaman berhasil dikirim");

      // Kembali ke halaman sebelumnya atau dashboard
      Get.back();
    } catch (e) {
      _showSnackbar("Error", "Gagal mengirim peminjaman: $e", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
