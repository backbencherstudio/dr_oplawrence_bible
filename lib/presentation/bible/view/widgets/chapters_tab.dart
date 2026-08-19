import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'number_grid_tab.dart';
import '../../viewmodel/bible_books_riverpod.dart';

class ChaptersTab extends ConsumerWidget {
  const ChaptersTab({super.key, required this.onChapterSelected});

  final ValueChanged<int> onChapterSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedBookIndexProvider);
    final booksAsync = ref.watch(bibleBooksProvider);

    return booksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Faild to Fetch Data")),
      data: (books) {
        if (selectedIndex == null) {
          return const Center(child: Text("Select a book first"));
        }

        final bookId = books[selectedIndex].id;
        final chaptersAsync = ref.watch(bibleChapterProvider(bookId));

        return chaptersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Something Went Wrong")),
          data: (chapters) {
            final selectedChapter = ref.watch(selectedChapterIndexProvider);

            return NumberGridTab(
              numbers: chapters.map((c) => c.number).toList(),
              selectedIndex: selectedChapter,
              onNumberTap: (index) {
                final chapter = chapters[index];

                ref.read(selectedChapterIndexProvider.notifier).state = index;

                /// MARK CHAPTER COMPLETED
                final progressMap = ref.read(completedChaptersProvider);
                final updated = Map<String, Set<String>>.from(progressMap);
                updated.putIfAbsent(bookId, () => {});
                updated[bookId]!.add(chapter.id);
                ref.read(completedChaptersProvider.notifier).state = updated;

                ref.read(selectedChapterNumberProvider.notifier).state =
                    chapter.number;

                onChapterSelected(index);
              },
            );
          },
        );
      },
    );
  }
}
