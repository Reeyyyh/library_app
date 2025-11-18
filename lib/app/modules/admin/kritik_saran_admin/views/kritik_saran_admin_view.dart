import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/card_kritik_saran_admin.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/kritik_saran_admin_controller.dart';

class KritikSaranAdminView extends GetView<KritikSaranAdminController> {
  const KritikSaranAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Daftar Kritik & Saran'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kritik_saran')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Center(
                child: Text(
                  'No Data',
                  style: AppTheme.heading3.copyWith(
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final documentSnaphot = documents[index];
                  final item = documentSnaphot.data() as Map<String, dynamic>;
                  var userFuture = FirebaseFirestore.instance
                      .collection('users')
                      .doc(item['email'])
                      .get();

                  return FutureBuilder(
                    future: userFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return CardKritikSaranAdmin(
                          userData: userData,
                          item: item,
                        );
                      }
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
