import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/models/book_model.dart';


class CollectionController extends GetxController {

  var books = <BookModel>[].obs;

  var searchQuery = ''.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void fetchBooks() {
    FirebaseFirestore.instance
        .collection('books')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final fetchedBooks = snapshot.docs
          .map((doc) => BookModel.fromDoc(doc))
          .toList();
      books.value = fetchedBooks;
    });
  }

  List<BookModel> get filteredBooks {
    if (searchQuery.isEmpty) {
      return books;
    } else {
      final query = searchQuery.value.toLowerCase();
      return books
          .where((book) => book.judul.toLowerCase().contains(query))
          .toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchController.clear();
  }
}
