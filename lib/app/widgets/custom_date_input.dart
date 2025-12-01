import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateInput extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;
  final String placeholder;

  const CustomDateInput({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.placeholder = "Pilih tanggal",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                  : placeholder, // tampil placeholder jika belum ada tanggal
              style: TextStyle(
                fontSize: 16,
                color: selectedDate != null ? Colors.black : Colors.grey[600],
              ),
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}
// merge