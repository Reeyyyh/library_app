import 'package:get/get.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminLoanRequestController extends GetxController {
  final isLoading = true.obs;
  final loanRequests = <LoanRequestWithDetail>[].obs;

  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
    fetchLoanRequests();
  }

  Future<void> fetchLoanRequests() async {
    try {
      isLoading.value = true;

      final data = await supabase
          .from('loan_requests')
          .select('''
            *,
            users (*),
            books (*, categories (*))
          ''')
          .order('created_at', ascending: false);

      loanRequests.value = data
          .map<LoanRequestWithDetail>(
            (e) => LoanRequestWithDetail.fromMap(e),
          )
          .toList();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengambil data pengajuan",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ===== FILTER =====
  List<LoanRequestWithDetail> get pendingRequests =>
      loanRequests.where((e) => e.request.requestStatus == 'pending').toList();

  List<LoanRequestWithDetail> get acceptedRequests =>
      loanRequests.where((e) => e.request.requestStatus == 'accepted').toList();

  List<LoanRequestWithDetail> get returnedRequests =>
      loanRequests.where((e) => e.request.requestStatus == 'returned').toList();
}

