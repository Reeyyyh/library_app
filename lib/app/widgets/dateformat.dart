import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateFormat(Timestamp firestoreTimestamp) {
  final date = firestoreTimestamp.toDate();
  final formattedDate = DateFormat('dd MMMM yyyy').format(date);
  return formattedDate;
}
