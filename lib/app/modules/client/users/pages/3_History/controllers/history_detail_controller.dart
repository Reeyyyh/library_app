import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/modules/client/users/widgets/custom_dialog.dart';

class HistoryDetailController extends GetxController {
  // Reactive LoanRequest
  Rx<LoanRequest> loan = LoanRequest.empty().obs;

  final isLoading = false.obs;

  void setLoan(LoanRequest data) {
    loan.value = data;
  }

  String getBorrowDuration() {
    final formatter = DateFormat("dd/MM/yyyy");
    final returnDate = formatter.parse(loan.value.tanggalKembali);

    final now = DateTime.now();
    final diff = returnDate.difference(now).inDays;

    return diff >= 0 ? "$diff days left" : "${diff.abs()} days late";
  }

  // Cancel request
  void cancelRequest() {
    CustomDialog.confirm(
      title: "Batalkan Permintaan?",
      message:
          "Apakah Anda yakin ingin membatalkan permintaan ini? Tindakan ini tidak dapat dibatalkan.",
      confirmColor: Colors.red,
      onConfirm: () async {
        await _doCancel();
      },
    );
  }

  Future<void> _doCancel() async {
    if (loan.value.id == null) {
      Get.snackbar("Error", "Cannot cancel: missing document ID");
      return;
    }

    isLoading.value = true;

    try {
      await FirebaseFirestore.instance
          .collection('borrow_requests')
          .doc(loan.value.id)
          .update({'requestStatus': 'cancelled'});

      loan.value = loan.value.copyWith(requestStatus: 'cancelled');

      Get.snackbar(
        "Success",
        "Request has been cancelled",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to cancel request: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Return book
  void returnBook() {
    CustomDialog.confirm(
      title: "Kembalikan Buku?",
      message:
          "Kembalikan buku sekarang?",
      confirmColor: Colors.green,
      onConfirm: () async {
        await _doReturn();
      },
    );
  }

  Future<void> _doReturn() async {
    if (loan.value.id == null) {
      Get.snackbar("Error", "Cannot return: missing document ID");
      return;
    }

    isLoading.value = true;

    try {
      final today = DateFormat("dd/MM/yyyy").format(DateTime.now());

      await FirebaseFirestore.instance
          .collection('borrow_requests')
          .doc(loan.value.id)
          .update({
        'requestStatus': 'returned',
        'returnDate': today,
      });

      loan.value = loan.value.copyWith(
        requestStatus: 'returned',
        returnDate: today,
      );

      Get.snackbar(
        "Success",
        "Book returned successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to return book: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
// merge