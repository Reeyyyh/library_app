import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';
import 'package:library_app/app/models/menu_model.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/modules/auth/views/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

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

    _fetchAllCounts();
    fetchLoanRequests();

    _setupRealtimeListeners();
  }

  // =====================================================
  // FETCH ALL COUNTS
  // =====================================================
  Future<void> _fetchAllCounts() async {
    await _fetchCount('books', 0);
    await _fetchCount('categories', 1);
    await _fetchCount('loan_requests', 2);
    await _fetchCount('users', 3);
  }

  Future<void> _fetchCount(String table, int index) async {
    List<dynamic> result;

    if (table == 'loan_requests') {
      result = await supabase
          .from(table)
          .select('id')
          .eq('request_status', 'pending');
    } else {
      result = await supabase.from(table).select('id');
    }

    menus[index] = menus[index].copyWith(count: result.length);
    menus.refresh();
  }

  // =====================================================
  // LOAN REQUESTS DETAIL
  // =====================================================
  RxList<LoanRequestWithDetail> loanRequests = <LoanRequestWithDetail>[].obs;

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
          .eq('request_status', 'pending')
          .order('tanggal_pinjam', ascending: false);

      loanRequests.value = data
          .map<LoanRequestWithDetail>(LoanRequestWithDetail.fromMap)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data pengajuan: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // =====================================================
  // REALTIME SUBSCRIPTIONS
  // =====================================================
  void _setupRealtimeListeners() {
    // Books
    supabase
        .channel('realtime:books')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'books',
          callback: (payload) {
            _fetchCount('books', 0);
          },
        )
        .subscribe();

    // Categories
    supabase
        .channel('realtime:categories')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'categories',
          callback: (payload) {
            _fetchCount('categories', 1);
          },
        )
        .subscribe();

    // Loan Requests
    supabase
        .channel('realtime:loan_requests')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'loan_requests',
          callback: (payload) {
            _fetchCount('loan_requests', 2);
            fetchLoanRequests();
          },
        )
        .subscribe();

    // Users
    supabase
        .channel('realtime:users')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'users',
          callback: (payload) {
            _fetchCount('users', 3);
          },
        )
        .subscribe();
  }

  // =====================================================
  // REFRESH
  // =====================================================
  Future<void> refreshLoanRequests() async {
    await fetchLoanRequests();
  }

  // =====================================================
  // LOGOUT
  // =====================================================
  Future<void> logout() async {
    try {
      await auth.logout();

      Get.snackbar("Sukses", "Logout berhasil",
          backgroundColor: Colors.green, colorText: Colors.white);

      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar("Error", "Gagal logout: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
