import 'package:book_library_app/models/books_response_model.dart';
import 'package:book_library_app/views/widgets/read_button.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.network(
            "https://covers.openlibrary.org/b/id/${book.coverId}-M.jpg",
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title ?? '', style: const TextStyle(fontSize: 16.0)),
                Text(book.authorNames.join(", ")),
                Text("Published: ${book.firstPublishYear}"),
                ReadButton(book: book),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
