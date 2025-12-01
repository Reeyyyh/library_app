import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateFormat(Timestamp firestoreTimestamp) {
  final date = firestoreTimestamp.toDate();
  final formattedDate = DateFormat('dd MMMM yyyy').format(date);
  return formattedDate;
}

String dateFormatFromString(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat("d MMM yyyy", "id_ID").format(parsedDate);
}

String dateFormatFromStringFull(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat("d MMMM yyyy", "id_ID").format(parsedDate);
}

String dateFormatFromDateTime(Timestamp date) {
  return DateFormat("d MMMM yyyy, HH:mm", "id_ID").format(date.toDate());
}
