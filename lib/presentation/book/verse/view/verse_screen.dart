import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/bible_model.dart';
import '../../../../data/repository/bible_repository.dart';
import '../../screens/verse_image_downloader/verse_image_downloader.dart';
import '../../viewmodel/bible_books_riverpod.dart';
import '../viewmodel/verse_riverpod.dart';

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
  final Set<int> highlightedIndexes = {};
  final Map<int, String> notes = {};

  late SharedPreferences prefs;

  String get _highlightKey =>
      'highlight_${ref.read(selectedBookNameProvider)}_${ref.read(selectedChapterNumberProvider)}';

  String get _noteKey =>
      'notes_${ref.read(selectedBookNameProvider)}_${ref.read(selectedChapterNumberProvider)}';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // =================== Save Bookmark ==================
  Future<void> _addBookmark(int index, String verseText) async {
    final prefs = await SharedPreferences.getInstance();

    final bookName = ref.read(selectedBookNameProvider) ?? '';
    final chapterNumber = ref.read(selectedChapterNumberProvider) ?? 0;

    List<String> bookmarks = prefs.getStringList('bookmarks_list') ?? [];

    String bookmark = "$bookName|$chapterNumber|$index|$verseText";

    // Prevent duplicate bookmarks
    if (!bookmarks.contains(bookmark)) {
      bookmarks.add(bookmark);
      await prefs.setStringList('bookmarks_list', bookmarks);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Bookmark added")));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Already bookmarked")));
      }
    }
  }

  // ============ Load Data ================
  Future<void> _loadData() async {
    prefs = await SharedPreferences.getInstance();

    final highlights = prefs.getStringList(_highlightKey) ?? [];
    final notesMap = prefs.getStringList(_noteKey) ?? [];

    setState(() {
      highlightedIndexes.addAll(highlights.map(int.parse));

      for (var item in notesMap) {
        final parts = item.split('|');
        if (parts.length >= 2) {
          notes[int.parse(parts[0])] = parts[1];
        }
      }
    });
  }

  // ================ Save HighLight ====================
  Future<void> _saveHighlights() async {
    await prefs.setStringList(
      _highlightKey,
      highlightedIndexes.map((e) => e.toString()).toList(),
    );
  }

  // =================== Save Note Part ==================
  Future<void> _saveNotes() async {
    final list = notes.entries.map((e) => '${e.key}|${e.value}').toList();
    await prefs.setStringList(_noteKey, list);
  }

  void _toggleHighlight(int index) {
    setState(() {
      highlightedIndexes.contains(index)
          ? highlightedIndexes.remove(index)
          : highlightedIndexes.add(index);
    });
    _saveHighlights();
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
          initialNote: notes[index] ?? '',
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (result.toString().trim().isEmpty) {
          notes.remove(index);
        } else {
          notes[index] = result;
        }
      });
      _saveNotes();
    }
  }

  // ================ Show Note Using POP ================
  void _showNotePopup(int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: MediaQuery.of(context).size.width - 32,
            margin: EdgeInsets.only(top: 40.h),
            padding: EdgeInsets.all(16.w),
            child: Text(
              notes[index] ?? '',
              style: GoogleFonts.merriweather(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  // =========== open the dialog and show option ==============
  void _showOptions(BuildContext context, int index, String verseText) {
    final width = MediaQuery.of(context).size.width;
    final bookName = ref.read(selectedBookNameProvider) ?? '';
    final chapterNumber = ref.read(selectedChapterNumberProvider) ?? 0;

    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: width * 0.14.h,
            width: width - 32.w,
            margin: EdgeInsets.only(top: 100.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _optionTile(
                  icon: "assets/icons/copy.svg",
                  title: 'Copy',
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: verseText));
                    Navigator.pop(context);
                  },
                ),
                _optionTile(
                  icon: "assets/icons/image.svg",
                  title: 'Image',
                  onTap: () {
                    Navigator.pop(context);
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
                ),
                _optionTile(
                  icon: "assets/icons/highlight.svg",
                  title: highlightedIndexes.contains(index)
                      ? 'Remove'
                      : 'Highlight',
                  onTap: () {
                    _toggleHighlight(index);
                    Navigator.pop(context);
                  },
                ),
                _optionTile(
                  icon: "assets/icons/multiple.svg",
                  title: 'Bookmark',
                  onTap: () async {
                    Navigator.pop(context);
                    await _addBookmark(index, verseText);
                  },
                ),
                _optionTile(
                  icon: "assets/images/notes.svg",
                  title: 'Note',
                  onTap: () {
                    Navigator.pop(context);
                    _openNoteEditor(index, verseText);
                  },
                ),
                // _optionTile(
                //   icon: "assets/icons/explore.svg",
                //   title: 'Explore',
                //   onTap: () => Navigator.pop(context),
                // ),
                _optionTile(
                  icon: "assets/icons/explore.svg",
                  title: 'Explore',
                  onTap: () {
                    Navigator.pop(context);

                    ref
                        .read(bibleExplanationProvider.notifier)
                        .fetchExplanation(
                          bookName: bookName,
                          chapter: chapterNumber,
                          verseNumber: index + 1,
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, color: Colors.white),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.white),
          ),
        ],
      ),
    );
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
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // =============== book name & chapter number ===========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Text(
                "$bookName $chapterNumber",
                style: TextStyle(
                  color: Color(0xFFB71C1C),
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
            ),
            // =================== Ai Verse Added ============
            if (explanation != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity.w,
                      padding: EdgeInsets.all(13.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 22, 94, 24),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            'Explanation:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            explanation.explanation ?? "",
                            style: TextStyle(
                              color: Color.fromARGB(255, 22, 94, 24),
                              fontSize: 16.sp,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ===== Close Button =====
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: GestureDetector(
                        onTap: () {
                          // Clear the explanation
                          ref.read(bibleExplanationProvider.notifier).state =
                              null;
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.w),

                          child: const Icon(
                            Icons.cancel_rounded,
                            size: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // =============== ListView and details of the verse ==========
            Expanded(
              child: FutureBuilder<dynamic>(
                future: widget.bibleRepository.getBibleVerse(widget.chapterId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No verses found.'));
                  }
                  final List<BibleVerse> verses = (snapshot.data as List)
                      .map((json) => BibleVerse.fromJson(json))
                      .toList();

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: verses.length,
                    itemBuilder: (context, index) {
                      final verse = verses[index];
                      final hasNote = notes.containsKey(index);
                      final isHighlighted = highlightedIndexes.contains(index);

                      return GestureDetector(
                        onLongPress: () =>
                            _showOptions(context, index, verse.text),
                        child: Stack(
                          children: [
                            VerseCard(
                              number: verse.number.toString(),
                              text: verse.text,
                              isHighlighted: isHighlighted,
                            ),
                            if (hasNote)
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: GestureDetector(
                                  onTap: () => _showNotePopup(index),
                                  child: SvgPicture.asset(
                                    'assets/icons/desc.svg',
                                    color: Colors.blueAccent.shade700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ======== UPDATED NOTE EDIT SCREEN (ACCURATE DESIGN) =========
class NoteEditScreen extends StatelessWidget {
  final String title;
  final String verseNumber;
  final String verseText;
  final String initialNote;

  const NoteEditScreen({
    super.key,
    required this.title,
    required this.verseNumber,
    required this.verseText,
    required this.initialNote,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: initialNote,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // ========= Back Button ============
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, size: 20.w),
                ),
              ),
              SizedBox(height: 20),
              // Title
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFFB71C1C),
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              SizedBox(height: 25.h),
              // Verse Box (Grey Background)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), // Softer light grey
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      verseNumber,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      verseText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        height: 1.4.h,
                        color: Color(0xFF424242),
                        fontFamily: 'Georgia',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // --- UPDATED EDITING FIELD ---
              Container(
                height: 220.h, // Increased height to match image proportions
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), // Matching grey
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  expands: true, // Allows field to fill the container
                  textAlignVertical:
                      TextAlignVertical.top, // Text starts at top
                  decoration: InputDecoration(
                    hintText: "I love this reading...",
                    hintStyle: TextStyle(color: Color(0xFF757575)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(
                      16.w,
                    ), // Padding inside the box
                  ),
                  style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                ),
              ),
              const Spacer(),
              // Save Button
              SizedBox(
                width: double.infinity.w,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F3B96),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= Verse Card ================
class VerseCard extends StatelessWidget {
  final String number;
  final String text;
  final bool isHighlighted;

  const VerseCard({
    super.key,
    required this.number,
    required this.text,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xffDFF5E7) : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: Color(0xFFD4AF37),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      number,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        height: 1.4.h,
                        color: Color(0xFF424242),
                        fontFamily: 'Georgia',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
