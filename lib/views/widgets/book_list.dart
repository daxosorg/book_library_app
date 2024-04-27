import 'package:book_library_app/models/books_response_model.dart';
import 'package:book_library_app/views/widgets/book_item.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  const BookList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) => BookItem(book: books[index]),
    );
  }
}
