import 'package:book_library_app/models/books_response_model.dart';
import 'package:flutter/material.dart';

class ReadButton extends StatefulWidget {
  final Book book;

  const ReadButton({super.key, required this.book});

  @override
  State<ReadButton> createState() => _ReadButtonState();
}

class _ReadButtonState extends State<ReadButton> {
  bool isRead = false;

  @override
  void initState() {
    super.initState();
    isRead = widget.book.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          isRead = !isRead;
          widget.book.isRead = isRead;
        });
      },
      style: TextButton.styleFrom(
        side: BorderSide(
          color: !isRead ? Colors.grey : Colors.transparent,
        ),
      ),
      child: Text(
        isRead ? "Read" : "Unread",
        style: TextStyle(color: isRead ? Colors.green : Colors.black),
      ),
    );
  }
}
