import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/bible_books_riverpod.dart';
import 'book_list_tile.dart';

class BooksTab extends ConsumerWidget {
  const BooksTab({super.key, required this.onBookSelected});

  final ValueChanged<int> onBookSelected;

  double calculateProgress(
    String bookId,
    int totalChapters,
    Map<String, Set<String>> progressMap,
  ) {
    final completed = progressMap[bookId]?.length ?? 0;
    if (totalChapters == 0) return 0;
    return (completed / totalChapters) * 100;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(bibleBooksProvider);
    final selectedIndex = ref.watch(selectedBookIndexProvider);
    final progressMap = ref.watch(completedChaptersProvider);

    return booksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Failed to fetch data")),
      data: (books) {
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            final isSelected = selectedIndex == index;

            return BookListTile(
              book: book,
              isSelected: isSelected,
              progressMap: progressMap,
              calculateProgress: calculateProgress,
              onTap: () {
                ref.read(selectedBookIndexProvider.notifier).state = index;
                ref.read(selectedBookNameProvider.notifier).state = book.name;
                onBookSelected(index);
              },
            );
          },
        );
      },
    );
  }
}

