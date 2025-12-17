import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorMessage;
  final bool readonly;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(String)? onChange;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorMessage,
    this.readonly = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChange,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage ?? '';

    // Fungsi untuk memilih tanggal
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2100),
      );
      if (picked != null && picked != widget.controller.text) {
        setState(() {
          widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
        });
        if (widget.onChange != null) {
          widget.onChange!(widget.controller.text);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            color: errorMessage.isNotEmpty ? Colors.red : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: widget.controller,
          readOnly: widget.readonly,
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
                color: errorMessage.isNotEmpty ? Colors.red : Colors.blue,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              color: errorMessage.isNotEmpty ? Colors.red : Colors.grey[700],
              onPressed: widget.readonly
                  ? null
                  : () => selectDate(context), // Open date picker
            ),
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              '*$errorMessage',
              style: TextStyle(
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
