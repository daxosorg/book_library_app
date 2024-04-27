import 'dart:developer';

import 'package:book_library_app/models/books_response_model.dart';
import 'package:book_library_app/views/widgets/book_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() => isLoading = true);
    final dio = Dio();
    try {
      final response = await dio.get("https://openlibrary.org/people/mekBot/books/already-read.json");
      if (response.statusCode == 200) {
        final BookResponseModel responseModel = BookResponseModel.fromJson(response.data);
        books = responseModel.readingLogEntries.map((item) => item.book).toList().sublist(0, 20); // Only 20 items
        setState(() {});
      } else {
        log("API Error");
      }
    } on DioException catch (e) {
      log("Error fetching books: ${e.message}");
    } catch (e) {
      log("Unexpected error: ${e.toString()}");
    }
    setState(() => isLoading = false);
  }

  List<Book> searchResultBooks = [];

  Future<void> _handleSearch(String query) async {
    if (query.isEmpty) return;
    setState(() => isLoading = true);

    final dio = Dio();
    try {
      final response = await dio.get("https://openlibrary.org/search.json?q={$query}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> docs = data['docs'] ?? [];
        setState(() {
          searchResultBooks = docs.map((json) {
            return Book.fromJsonForSearchResult(json);
          }).toList();
        });
      } else {
        log("Api errro");
      }
    } on DioException catch (e) {
      log("Error searching books: ${e.message}");
    } catch (e) {
      log("Unexpected error: ${e.toString()}");
    }
    setState(() => isLoading = false);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Library"),
      ),
      body: Column(
        mainAxisAlignment: isLoading ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: isLoading
            ? [const Center(child: CircularProgressIndicator())]
            : [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    onEditingComplete: () => _handleSearch(searchController.text),
                    decoration: InputDecoration(
                      hintText: "Search for books",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          searchResultBooks.clear();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BookList(books: searchResultBooks.isNotEmpty ? searchResultBooks : books),
                ),
              ],
      ),
    );
  }
}
