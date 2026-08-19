import 'package:shared_preferences/shared_preferences.dart';

class VerseAnnotationsController {
  VerseAnnotationsController({
    required this.bookName,
    required this.chapterNumber,
  });

  final String bookName;
  final int chapterNumber;
  final Set<int> highlightedIndexes = {};
  final Map<int, String> notes = {};

  String get _highlightKey => 'highlight_${bookName}_$chapterNumber';
  String get _noteKey => 'notes_${bookName}_$chapterNumber';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    highlightedIndexes
      ..clear()
      ..addAll((prefs.getStringList(_highlightKey) ?? []).map(int.parse));

    notes.clear();
    for (final item in prefs.getStringList(_noteKey) ?? <String>[]) {
      final parts = item.split('|');
      if (parts.length >= 2) {
        notes[int.parse(parts[0])] = parts[1];
      }
    }
  }

  /// Toggles the highlight state for [index] and persists the change.
  Future<void> toggleHighlight(int index) async {
    highlightedIndexes.contains(index)
        ? highlightedIndexes.remove(index)
        : highlightedIndexes.add(index);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _highlightKey,
      highlightedIndexes.map((e) => e.toString()).toList(),
    );
  }

  /// Sets (or clears, if [text] is null/blank) the note for [index] and
  /// persists the change.
  Future<void> setNote(int index, String? text) async {
    if (text == null || text.trim().isEmpty) {
      notes.remove(index);
    } else {
      notes[index] = text;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _noteKey,
      notes.entries.map((e) => '${e.key}|${e.value}').toList(),
    );
  }

  /// Adds a bookmark for the given verse. Returns `true` if it was newly
  /// added, `false` if that verse was already bookmarked.
  Future<bool> addBookmark(int index, String verseText) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarks_list') ?? [];
    final bookmark = "$bookName|$chapterNumber|$index|$verseText";

    if (bookmarks.contains(bookmark)) return false;

    bookmarks.add(bookmark);
    await prefs.setStringList('bookmarks_list', bookmarks);
    return true;
  }
}
