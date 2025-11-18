import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/layanan_controller.dart';

class LayananView extends GetView<LayananController> {
  const LayananView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LayananController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Layanan Perpustakaan'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        children: [
          Text(
            'Selamat Datang di Layanan Perpustakaan',
            style: AppTheme.heading1.copyWith(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Eksplorasi berbagai layanan perpustakaan yang kami sediakan untuk Anda.',
            style: AppTheme.heading2.copyWith(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemCount: controller.menus.length,
            itemBuilder: (context, index) {
              var item = controller.menus[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(item['route'].toString());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['icon'].toString(),
                        width: 75,
                        height: 75,
                      ),
                      SizedBox(height: 10),
                      Text(
                        item['title'].toString(),
                        style: AppTheme.heading2.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
