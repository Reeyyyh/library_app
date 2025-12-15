import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/models/user_model.dart';
import 'package:library_app/app/modules/client/users/widgets/custom_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryDetailController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  // Reactive user data
  RxMap<String, String> userData = <String, String>{}.obs;

  // Reactive LoanRequestWithDetail
  Rx<LoanRequestWithDetail> loan = LoanRequestWithDetail(
    request: LoanRequestModel(
      id: '',
      borrowCode: '',
      userId: '',
      bookId: '',
      tanggalPinjam: DateTime.now(),
      tanggalKembali: DateTime.now(),
      requestStatus: '',
    ),
    user: UserModel(
      id: '',
      name: '',
      email: '',
      kelas: '',
      kontak: '',
      role: 'user',
      isActive: true,
      image: '',
    ),
    book: BookWithCategoryModel(
      book: BookModel(
        id: '',
        judul: '',
        image: '',
        kategoriId: '',
        createdAt: DateTime.now(),
        penulis: '',
        penerbit: '',
        tahun: '',
        stok: 0,
        status: BookStatus.tersedia,
        deskripsi: '',
      ),
      category: CategoryModel(
        id: '',
        name: '',
        position: 0, // harus ada
      ),
    ),
  ).obs;

  final isLoading = false.obs;

  /// Set loan dengan LoanRequestWithDetail
  void setLoan(LoanRequestWithDetail data) async {
    loan.value = data;

    // Jika data user kosong, fetch dari supabase
    if (data.user.id.isEmpty) {
      try {
        final user = await supabase
            .from('users')
            .select('name, email, kelas, kontak')
            .eq('id', data.request.userId)
            .maybeSingle();

        if (user != null) {
          userData.value = {
            'name': user['name'] ?? '',
            'email': user['email'] ?? '',
            'kelas': user['kelas'] ?? '',
            'kontak': user['kontak'] ?? '',
          };
        }
      } catch (e) {
        print("Failed fetch user data: $e");
      }
    } else {
      userData.value = {
        'name': data.user.name,
        'email': data.user.email,
        'kelas': data.user.kelas,
        'kontak': data.user.kontak,
      };
    }
  }

  /// Dapatkan durasi pinjam
  String getBorrowDuration() {
    final now = DateTime.now();
    final diff = loan.value.request.tanggalKembali.difference(now).inDays;
    return diff >= 0 ? "$diff hari tersisa" : "${diff.abs()} hari terlambat";
  }

  /// Batalkan request
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
    if (loan.value.request.id.isEmpty) {
      print("DEBUG: loan id kosong, cannot cancel");
      Get.snackbar("Error", "Cannot cancel: missing ID");
      return;
    }

    isLoading.value = true;

    try {
      print("DEBUG: cancelling loan with id = ${loan.value.request.id}");

      final response = await supabase.from('loan_requests').update(
          {'request_status': 'cancelled'}).eq('id', loan.value.request.id);

      // Supabase Flutter v1+ tidak punya 'error' di response, ini kalau kamu pakai v0.2x
      print("DEBUG: supabase update response = $response");

      // Update reactive
      loan.value = loan.value.copyWith(
        request: loan.value.request.copyWith(requestStatus: 'cancelled'),
      );

      print("DEBUG: reactive loan updated");

      Get.snackbar(
        "Success",
        "Request has been cancelled",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e, st) {
      print("DEBUG: error while cancelling = $e");
      print("DEBUG: stacktrace = $st");
      Get.snackbar("Error", "Failed to cancel request: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Kembalikan buku
  void returnBook() {
    CustomDialog.confirm(
      title: "Kembalikan Buku?",
      message: "Kembalikan buku sekarang?",
      confirmColor: Colors.green,
      onConfirm: () async {
        await _doReturn();
      },
    );
  }

  Future<void> _doReturn() async {
    if (loan.value.request.id.isEmpty) {
      Get.snackbar("Error", "Cannot return: missing ID");
      return;
    }

    isLoading.value = true;

    try {
      final today = DateTime.now();

      final response = await supabase.from('loan_requests').update({
        'request_status': 'returned',
        'return_date': today.toIso8601String(),
      }).eq('id', loan.value.request.id);

      if (response.error != null) {
        throw response.error!.message;
      }

      loan.value = loan.value.copyWith(
        request: loan.value.request.copyWith(
          requestStatus: 'returned',
          returnDate: today,
        ),
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
