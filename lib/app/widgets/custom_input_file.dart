import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/app/constants/theme.dart';

class CustomFileInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? errorMessage;
  final VoidCallback onPressed;
  final String? placeholder;
  final String? pdfUrl;

  const CustomFileInput({
    Key? key,
    required this.labelText,
    required this.controller,
    this.errorMessage,
    required this.onPressed,
    this.placeholder,
    this.pdfUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Jika errorMessage null, kita set ke string kosong
    final errorMessage = this.errorMessage ?? '';
    final placeholderText = placeholder ?? 'Pilih file';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: errorMessage.isNotEmpty ? Colors.red : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        pdfUrl != null
            ? GestureDetector(
                onTap: () {
                  Get.toNamed('/pdf-reader', arguments: pdfUrl);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Lihat PDF',
                        style: AppTheme.heading2.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        pdfUrl != null
            ? const SizedBox(height: 8.0)
            : const SizedBox(height: 0),
        TextField(
          controller: controller,
          readOnly: true, // Hanya untuk menampilkan file yang dipilih
          decoration: InputDecoration(
            hintText: controller.text.isEmpty ? placeholderText : null,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty ? Colors.red : Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty ? Colors.red : Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty ? Colors.red : Colors.blue,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: onPressed,
              color: errorMessage.isNotEmpty ? Colors.red : Colors.grey[700],
            ),
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              '*$errorMessage',
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
