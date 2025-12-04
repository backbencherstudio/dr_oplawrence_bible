import 'package:dr_oplawrence_bible/data/sources/services/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Bible Books")),

      body: booksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        
        error: (err, stack) => Center(
          child: Text("Error: $err"),
        ),
        
        data: (data) {
          final books = data["books"] as List;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];

              return ListTile(
                title: Text(book["name"]),
                trailing: Text("${book['chapters'].length} chapters"),
              );
            },
          );
        },
      ),
    );
  }
}
