import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_app/app/models/loan_request_model.dart';

class HistoryController extends GetxController {
  var isLoading = true.obs;
  var borrowHistory = <LoanRequest>[].obs;

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  void fetchHistory() async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        isLoading.value = false;
        return;
      }

      FirebaseFirestore.instance
          .collection('borrow_requests')
          .where('uid', isEqualTo: user.uid) // <-- disamakan dengan field model
          .snapshots()
          .listen((snapshot) {
        borrowHistory.value =
            snapshot.docs.map((doc) => LoanRequest.fromMap(doc.data())).toList();

        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      print("Error fetch history: $e");
    }
  }
}
