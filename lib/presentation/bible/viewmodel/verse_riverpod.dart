import 'package:flutter_riverpod/legacy.dart';

import '../../../data/models/bible_model.dart';
import '../../../data/repository/bible_repository.dart';
import 'bible_books_riverpod.dart';

class BibleExplanationNotifier extends StateNotifier<BibleAiExplanationModel?> {
  final BibleRepository repository;

  BibleExplanationNotifier(this.repository) : super(null);

  Future<void> fetchExplanation({
    required String bookName,
    required int chapter,
    required int verseNumber,
  }) async {
    try {
      final result = await repository.getBibleExplanation(
        bookName: bookName,
        chapter: chapter,
        verseNumber: verseNumber,
      );

      state = result;
    } catch (e) {
      print(e);
    }
  }
}

final bibleExplanationProvider =
    StateNotifierProvider<BibleExplanationNotifier, BibleAiExplanationModel?>((
      ref,
    ) {
      final repo = ref.read(bibleRepositoryProvider);
      return BibleExplanationNotifier(repo);
    });

