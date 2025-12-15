import 'package:library_app/app/dtos/book_with_category_model.dart';
import 'package:library_app/app/models/loan_request_model.dart';
import 'package:library_app/app/models/user_model.dart';

class LoanRequestWithDetail {
  final LoanRequestModel request;
  final UserModel user;
  final BookWithCategoryModel book;

  LoanRequestWithDetail({
    required this.request,
    required this.user,
    required this.book,
  });

  factory LoanRequestWithDetail.fromMap(Map<String, dynamic> map) {
    return LoanRequestWithDetail(
      request: LoanRequestModel.fromMap(map),
      user: UserModel.fromMap(map['users']),
      book: BookWithCategoryModel.fromMap(map['books']),
    );
  }

  LoanRequestWithDetail copyWith({
    LoanRequestModel? request,
    UserModel? user,
    BookWithCategoryModel? book,
  }) {
    return LoanRequestWithDetail(
      request: request ?? this.request,
      user: user ?? this.user,
      book: book ?? this.book,
    );
  }
}
