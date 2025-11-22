import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class CustomSelect extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? errorMessage;
  final List<Map<String, dynamic>> items;
  final Function(int?)? onChanged;

  const CustomSelect({
    super.key,
    required this.labelText,
    required this.controller,
    this.errorMessage,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Jika errorMessage null, kita set ke string kosong
    final errorMessage = this.errorMessage ?? '';

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
        DropdownButtonFormField<int>(
          value: controller.text.isEmpty ? null : int.tryParse(controller.text),
          decoration: InputDecoration(
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
                color: errorMessage.isNotEmpty
                    ? Colors.red
                    : CustomAppTheme.primaryColor,
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          items: items.map((category) {
            return DropdownMenuItem<int>(
              value: category['index'],
              child: Text(
                category['data']['name'] ?? 'Nama Tidak Tersedia',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
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
