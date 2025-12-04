import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksRepository {

  Future<Map<String, dynamic>> parseBooksJson(String jsonString) async {
    return jsonDecode(jsonString);
  }


  Future<Map<String, dynamic>> loadBooks() async {
    // Load file as string (fast)
    final raw = await rootBundle.loadString('assets/books/sacred_scriptures.json');

    // Parse in background isolate (non-blocking)
    final parsed = await compute(parseBooksJson, raw);

    return parsed;
  }
}

final booksProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repo = BooksRepository();
  return repo.loadBooks();
});