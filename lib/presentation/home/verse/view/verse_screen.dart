import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/bible_model.dart';
import '../../../../data/repository/bible_repository.dart';
import '../../book/screens/verse_image_downloader/verse_image_downloader.dart';
import '../../book/viewmodel/bible_books_riverpod.dart';
import '../viewmodel/verse_riverpod.dart';
import 'widgets/app_snackbar.dart';
import 'widgets/chapter_header_title.dart';
import 'widgets/circle_back_button.dart';
import 'widgets/note_edit_screen.dart';
import 'widgets/verse_action_sheet.dart';
import 'widgets/verse_annotation_controller.dart';
import 'widgets/verse_explanation_panel.dart';
import 'widgets/verse_list.dart';

class VerseScreen extends ConsumerStatefulWidget {
  final String chapterId;
  final BibleRepository bibleRepository;

  const VerseScreen({
    super.key,
    required this.chapterId,
    required this.bibleRepository,
  });

  @override
  ConsumerState<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends ConsumerState<VerseScreen> {
  late Future<List<BibleVerse>> versesFuture;
  late VerseAnnotationsController annotations;

  @override
  void initState() {
    super.initState();

    versesFuture = widget.bibleRepository
        .getBibleVerse(widget.chapterId)
        .then(
          (response) => (response as List)
              .map((json) => BibleVerse.fromJson(json))
              .toList(),
        );

    annotations = VerseAnnotationsController(
      bookName: ref.read(selectedBookNameProvider) ?? '',
      chapterNumber: ref.read(selectedChapterNumberProvider) ?? 0,
    );
    annotations.load().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final explanation = ref.watch(bibleExplanationProvider);
    final bookName = ref.watch(selectedBookNameProvider) ?? '';
    final chapterNumber = ref.watch(selectedChapterNumberProvider) ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 10.h),
              child: CircleBackButton(onTap: () => Navigator.pop(context)),
            ),
            ChapterHeaderTitle(
              bookName: bookName,
              chapterNumber: chapterNumber,
            ),
            VerseExplanationPanel(
              explanation: explanation,
              onClose: () {
                ref.read(bibleExplanationProvider.notifier).state = null;
              },
            ),
            Expanded(
              child: VerseList(
                future: versesFuture,
                highlightedIndexes: annotations.highlightedIndexes,
                noteIndexes: annotations.notes.keys.toSet(),
                onVerseLongPress: (verse, index) =>
                    _showOptions(context, index, verse.text),
                onNoteTap: _showNotePopup,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=========== Helper methods===========
  Future<void> _addBookmark(int index, String verseText) async {
    final added = await annotations.addBookmark(index, verseText);
    if (!mounted) return;
    showAppSnackBar(context, added ? "Bookmark added" : "Already bookmarked");
  }

  Future<void> _toggleHighlight(int index) async {
    await annotations.toggleHighlight(index);
    if (mounted) setState(() {});
  }

  // ================= Note Editing =====================
  void _openNoteEditor(int index, String verseText) async {
    final bookName = ref.read(selectedBookNameProvider) ?? '';
    final chapterNumber = ref.read(selectedChapterNumberProvider) ?? 0;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(
          title: "$bookName $chapterNumber",
          verseNumber: (index + 1).toString(),
          verseText: verseText,
          initialNote: annotations.notes[index] ?? '',
        ),
      ),
    );

    if (result != null) {
      await annotations.setNote(index, result.toString());
      if (mounted) setState(() {});
    }
  }

  // ================ Show Note Using POP ================
  void _showNotePopup(int index) {
    showVerseNotePopup(context, annotations.notes[index] ?? '');
  }

  // =========== open the dialog and show option ==============
  void _showOptions(BuildContext context, int index, String verseText) {
    final bookName = ref.read(selectedBookNameProvider) ?? '';
    final chapterNumber = ref.read(selectedChapterNumberProvider) ?? 0;

    showVerseActionSheet(
      context: context,
      verseText: verseText,
      isHighlighted: annotations.highlightedIndexes.contains(index),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: verseText));
      },
      onImage: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenVerseImage(
              backgroundAsset: "assets/images/home_upper.png",
              title: "$bookName $chapterNumber",
              verseText: verseText,
            ),
          ),
        );
      },
      onToggleHighlight: () => _toggleHighlight(index),
      onBookmark: () => _addBookmark(index, verseText),
      onNote: () => _openNoteEditor(index, verseText),
      onExplore: () {
        ref
            .read(bibleExplanationProvider.notifier)
            .fetchExplanation(
              bookName: bookName,
              chapter: chapterNumber,
              verseNumber: index + 1,
            );
      },
    );
  }
}
