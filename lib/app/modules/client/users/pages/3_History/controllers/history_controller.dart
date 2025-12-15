import 'dart:async';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_app/app/modules/auth/services/auth_service.dart';
import 'package:library_app/app/dtos/loan_request_with_detail.dart';

class HistoryController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final AuthService authService = Get.find<AuthService>();

  var isLoading = true.obs;
  var borrowHistory = <LoanRequestWithDetail>[].obs;
  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  // void fetchHistoryStream() {
  //   final currentUser = authService.userModel.value;
  //   if (currentUser == null) {
  //     isLoading.value = false;
  //     return;
  //   }

  //   isLoading.value = true;

  //   // Realtime stream dengan join ke books + categories + users
  //   _subscription = supabase
  //       .from('loan_requests')
  //       .stream(primaryKey: ['id'])
  //       .eq('user_id', currentUser.id)
  //       .order('tanggal_pinjam', ascending: false)
  //       .listen((loans) async {
  //     final result = await Future.wait(loans.map((loan) async {
  //       // Ambil book beserta kategori (join)
  //       final bookData = await supabase
  //           .from('books')
  //           .select('*, categories(*)')
  //           .eq('id', loan['book_id'])
  //           .maybeSingle();

  //       // Ambil user
  //       final userData = await supabase
  //           .from('users')
  //           .select()
  //           .eq('id', loan['user_id'])
  //           .maybeSingle();

  //       return LoanRequestWithDetail.fromMap({
  //         ...loan,
  //         'books': bookData ?? {},
  //         'users': userData ?? {},
  //       });
  //     }));

  //     borrowHistory.value = result;
  //     isLoading.value = false;
  //   });
  // }

  Future<void> fetchHistory() async {
    final currentUser = authService.userModel.value;
    if (currentUser == null) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    final loans = await supabase
        .from('loan_requests')
        .select()
        .eq('user_id', currentUser.id)
        .order('tanggal_pinjam', ascending: false);

    final result = await Future.wait((loans as List).map((loan) async {
      final bookData = await supabase
              .from('books')
              .select('*, categories(*)')
              .eq('id', loan['book_id'])
              .maybeSingle() ??
          {};

      final userData = await supabase
              .from('users')
              .select()
              .eq('id', loan['user_id'])
              .maybeSingle() ??
          {};

      return LoanRequestWithDetail.fromMap({
        ...loan,
        'books': Map<String, dynamic>.from(bookData),
        'users': Map<String, dynamic>.from(userData),
      });
    }));

    borrowHistory.value = result;
    isLoading.value = false;
  }
}
