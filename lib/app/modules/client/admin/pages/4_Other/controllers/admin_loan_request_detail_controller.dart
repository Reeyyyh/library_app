import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';

class AdminLoanRequestDetailController extends GetxController {
  final supabase = Supabase.instance.client;
  final loan = Rx<LoanRequestWithDetail?>(null);
  final isLoading = false.obs;

  AdminLoanRequestDetailController(LoanRequestWithDetail data) {
    loan.value = data;
  }

  Future<void> acceptRequest() async {
    try {
      isLoading.value = true;

      await supabase.from('loan_requests').update({
        'request_status': 'accepted',
      }).eq('id', loan.value!.request.id);

      loan.value = loan.value!.copyWith(
        request: loan.value!.request.copyWith(
          requestStatus: 'accepted',
        ),
      );

      Get.snackbar("Berhasil", "Permintaan disetujui");
    } catch (e) {
      Get.snackbar("Error", "Gagal menyetujui permintaan");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectRequest() async {
    try {
      isLoading.value = true;

      await supabase.from('loan_requests').update({
        'request_status': 'rejected',
      }).eq('id', loan.value!.request.id);

      loan.value = loan.value!.copyWith(
        request: loan.value!.request.copyWith(requestStatus: 'rejected'),
      );

      Get.snackbar("Ditolak", "Permintaan ditolak");
    } catch (e) {
      Get.snackbar("Error", "Gagal menolak permintaan");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markReturned() async {
    try {
      isLoading.value = true;

      await supabase.from('loan_requests').update({
        'request_status': 'returned',
        'return_date': DateTime.now().toIso8601String(),
      }).eq('id', loan.value!.request.id);

      loan.value = loan.value!.copyWith(
        request: loan.value!.request.copyWith(
          requestStatus: 'returned',
          returnDate: DateTime.now(),
        ),
      );

      Get.snackbar("Selesai", "Buku telah dikembalikan");
    } catch (e) {
      Get.snackbar("Error", "Gagal mengembalikan buku");
    } finally {
      isLoading.value = false;
    }
  }
}
