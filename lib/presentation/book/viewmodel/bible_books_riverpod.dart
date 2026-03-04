
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/network/api_clients.dart';
import '../../../data/models/bible_model.dart';
import '../../../data/repository/bible_repository.dart';
import '../../../data/sources/remote/bible_api_services.dart';

final bibleRepositoryProvider = Provider<BibleRepository>((ref) {
  return BibleRepository(apiService: BibleApiServices(apiClient: ApiClient()));
});

final bibleBooksProvider = FutureProvider<List<BibleBook>>((ref) async {
  final repository = ref.read(bibleRepositoryProvider);
  final response = await repository.getBibleBooks();

  // Parse response into List<BibleBook>
  return (response as List).map((json) => BibleBook.fromJson(json)).toList();
});
final selectedBookIndexProvider = StateProvider<int?>((ref) => null);


// ============== bible chapter ==============
final bibleChapterProvider =
    FutureProvider.family<List<BibleChapter>, String>((ref, bookId) async {
  final repository = ref.read(bibleRepositoryProvider);
  final response = await repository.getBibleChapter(bookId);

  return (response as List)
      .map((json) => BibleChapter.fromJson(json))
      .toList();
});

final selectedChapterIndexProvider = StateProvider<int?>((ref)=>null);
// ============== bible verse ==============
final bibleVerseProvider =
    FutureProvider.family<List<BibleVerse>, String>((ref, chapterId) async {
  final repository = ref.read(bibleRepositoryProvider);
  final response = await repository.getBibleVerse(chapterId);

  return (response as List)
      .map((json) => BibleVerse.fromJson(json))
      .toList();
});

final selectedVerseIndexProvider = StateProvider<int?>((ref)=>null);


// Stores the selected book name for header
final selectedBookNameProvider = StateProvider<String?>((ref) => null);

// Stores the selected chapter number for header
final selectedChapterNumberProvider = StateProvider<int?>((ref) => null);