import 'package:library_app/app/models/book_model.dart';
import 'package:library_app/app/models/category_model.dart';

class BookWithCategoryModel {
  final BookModel book;
  final CategoryModel category;

  BookWithCategoryModel({
    required this.book,
    required this.category,
  });

  factory BookWithCategoryModel.fromMap(Map<String, dynamic> map) {
    return BookWithCategoryModel(
      book: BookModel.fromMap(map),
      category: CategoryModel.fromMap(map['categories']),
    );
  }
}
