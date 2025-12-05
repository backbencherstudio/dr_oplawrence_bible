import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class BibleBook {
  final String name;
  final List<Chapter> chapters;

  BibleBook({required this.name, required this.chapters});

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      name: json["name"],
      chapters: (json["chapters"] as List)
          .map((c) => Chapter.fromJson(c))
          .toList(),
    );
  }
}

class Chapter {
  final int number;
  final List<String> verses;

  Chapter({required this.number, required this.verses});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      number: json["number"],
      verses: List<String>.from(json["verses"]),
    );
  }
}

class BibleViewModel {
  Future<List<BibleBook>> loadBooks() async {
    try {
      final jsonString = await rootBundle.loadString('assets/book/books.json');
      final jsonMap = json.decode(jsonString);
      final books = (jsonMap["books"] as List)
          .map((b) => BibleBook.fromJson(b))
          .toList();
      return books;
    } catch (e) {
      throw Exception("Failed to load books.json: $e");
    }
  }
}


class BookListScreen extends StatelessWidget {
  final BibleViewModel bibleVM;

  const BookListScreen({required this.bibleVM, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bible Books")),
      body: FutureBuilder<List<BibleBook>>(
        future: bibleVM.loadBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No books found"));
          }

          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text("${index + 1}. ${book.name}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),

                  subtitle: Text("${book.chapters.length} Chapters"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChapterListScreen(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class ChapterListScreen extends StatelessWidget {
  final BibleBook book;

  const ChapterListScreen({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: ListView.builder(
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          final chapter = book.chapters[index];
          return ListTile(
            title: Text("Chapter ${chapter.number}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VerseListScreen(
                    chapter: chapter,
                    bookName: book.name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VerseListScreen extends StatelessWidget {
  final Chapter chapter;
  final String bookName;

  const VerseListScreen({
    required this.chapter,
    required this.bookName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$bookName - Chapter ${chapter.number}")),
      body: ListView.builder(
        itemCount: chapter.verses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(chapter.verses[index]),
          );
        },
      ),
    );
  }
}

