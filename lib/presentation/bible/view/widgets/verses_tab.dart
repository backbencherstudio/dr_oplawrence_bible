import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/bible_books_riverpod.dart';
import '../verse_screen.dart';
import 'number_grid_tab.dart';

class VersesTab extends ConsumerWidget {
  const VersesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBook = ref.watch(selectedBookIndexProvider);
    final selectedChapter = ref.watch(selectedChapterIndexProvider);
    final booksAsync = ref.watch(bibleBooksProvider);

    return booksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Failed to fetch data")),
      data: (books) {
        if (selectedBook == null || selectedChapter == null) {
          return const Center(child: Text("Select chapter first"));
        }

        final bookId = books[selectedBook].id;
        final bibleRepository = ref.watch(bibleRepositoryProvider);
        final chaptersAsync = ref.watch(bibleChapterProvider(bookId));

        return chaptersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: ")),
          data: (chapters) {
            final chapterId = chapters[selectedChapter].id;
            final versesAsync = ref.watch(bibleVerseProvider(chapterId));

            return versesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error")),
              data: (verses) {
                return NumberGridTab(
                  numbers: verses.map((v) => v.number).toList(),
                  onNumberTap: (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseScreen(
                          chapterId: chapterId,
                          bibleRepository: bibleRepository,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
