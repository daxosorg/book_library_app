// To parse this JSON data, do
//
//     final bookResponseModel = bookResponseModelFromJson(jsonString);

import 'dart:convert';

BookResponseModel bookResponseModelFromJson(String str) => BookResponseModel.fromJson(json.decode(str));

String bookResponseModelToJson(BookResponseModel data) => json.encode(data.toJson());

class BookResponseModel {
  int page;
  int numFound;
  List<ReadingLogEntry> readingLogEntries;

  BookResponseModel({
    required this.page,
    required this.numFound,
    required this.readingLogEntries,
  });

  factory BookResponseModel.fromJson(Map<String, dynamic> json) => BookResponseModel(
        page: json["page"],
        numFound: json["numFound"],
        readingLogEntries: List<ReadingLogEntry>.from(json["reading_log_entries"].map((x) => ReadingLogEntry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "numFound": numFound,
        "reading_log_entries": List<dynamic>.from(readingLogEntries.map((x) => x.toJson())),
      };
}

class ReadingLogEntry {
  Book book;
  String? loggedEdition;
  String loggedDate;

  ReadingLogEntry({
    required this.book,
    required this.loggedEdition,
    required this.loggedDate,
  });

  factory ReadingLogEntry.fromJson(Map<String, dynamic> json) => ReadingLogEntry(
        book: Book.fromJson(json["work"]),
        loggedEdition: json["logged_edition"],
        loggedDate: json["logged_date"],
      );

  Map<String, dynamic> toJson() => {
        "work": book.toJson(),
        "logged_edition": loggedEdition,
        "logged_date": loggedDate,
      };
}

class Book {
  String? title;
  String key;
  List<String> authorKeys;
  List<String> authorNames;
  int? firstPublishYear;
  String? lendingEditionS;
  List<String>? editionKey;
  int? coverId;
  String? coverEditionKey;
  bool isRead;

  Book({
    required this.title,
    required this.key,
    required this.authorKeys,
    required this.authorNames,
    required this.firstPublishYear,
    required this.lendingEditionS,
    required this.editionKey,
    required this.coverId,
    required this.coverEditionKey,
    required this.isRead,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        key: json["key"],
        authorKeys: List<String>.from(json["author_keys"].map((x) => x)),
        authorNames: List<String>.from(json["author_names"].map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        lendingEditionS: json["lending_edition_s"],
        editionKey: json["edition_key"] == null ? [] : List<String>.from(json["edition_key"]!.map((x) => x)),
        coverId: json["cover_id"],
        coverEditionKey: json["cover_edition_key"],
        isRead: false,
      );

  factory Book.fromJsonForSearchResult(Map<String, dynamic> json) => Book(
        title: json["title"],
        key: "",
        authorKeys: [],
        authorNames: List<String>.from(json["author_name"].map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        lendingEditionS: '',
        editionKey: [],
        coverId: json["cover_i"],
        coverEditionKey: "",
        isRead: false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
        "author_keys": List<dynamic>.from(authorKeys.map((x) => x)),
        "author_names": List<dynamic>.from(authorNames.map((x) => x)),
        "first_publish_year": firstPublishYear,
        "lending_edition_s": lendingEditionS,
        "edition_key": editionKey == null ? [] : List<dynamic>.from(editionKey!.map((x) => x)),
        "cover_id": coverId,
        "cover_edition_key": coverEditionKey,
      };
}
