import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/pdf_reader_controller.dart';

class PdfReaderView extends GetView<PdfReaderController> {
  const PdfReaderView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(PdfReaderController());
    return Scaffold(
      appBar:CustomAppBar(title: 'Digital Book'),
      body: Obx(
        () => Container(
          child: SfPdfViewer.network(
            Uri.parse(controller.pdfPath.value).toString(),
          ),
        ),
      ),
    );
  }
}
