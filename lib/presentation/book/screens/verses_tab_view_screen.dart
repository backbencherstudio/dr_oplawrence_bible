import 'dart:io';
import 'dart:ui';
import 'package:dr_oplawrence_bible/presentation/book/screens/verse_image_downloader/verse_image_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../book_screen.dart';

class VerseTabView extends StatefulWidget {
  final Chapter chapter;
  final String bookName;

  const VerseTabView({
    required this.chapter,
    required this.bookName,
    super.key,
  });

  @override
  State<VerseTabView> createState() => _VerseTabViewState();
}

class _VerseTabViewState extends State<VerseTabView> {
  final GlobalKey _imageKey = GlobalKey();
  final Set<int> highlightedIndexes = {};
  final Map<int, String> notes = {};
  final Set<int> bookmarkedIndexes = {};

  late SharedPreferences prefs;

  String get _highlightKey =>
      'highlight_${widget.bookName}_${widget.chapter.number}';

  String get _noteKey => 'notes_${widget.bookName}_${widget.chapter.number}';

  static const String _bookmarkKey = 'bookmarks_list';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      if (kDebugMode) {
        print("Error capturing image: $e");
      }
      return null;
    }
  }

  Future<void> _saveToGallery(Uint8List bytes) async {
    // 1️⃣ Request permissions
    await Permission.photos.request();
    await Permission.storage.request();

    if (!await Permission.photos.isGranted &&
        !await Permission.storage.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Permission denied")));
      return;
    }

    try {
      // 2️⃣ Write bytes to temporary file
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // 3️⃣ Save file to gallery
      final success = await GallerySaver.saveImage(file.path);

      // 4️⃣ Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success == true ? "Saved to Gallery" : "Failed to Save",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> _loadData() async {
    prefs = await SharedPreferences.getInstance();

    final highlights = prefs.getStringList(_highlightKey) ?? [];
    final notesMap = prefs.getStringList(_noteKey) ?? [];
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];

    setState(() {
      highlightedIndexes.addAll(highlights.map(int.parse));

      for (var item in notesMap) {
        final parts = item.split('|');
        notes[int.parse(parts[0])] = parts[1];
      }

      for (var item in bookmarks) {
        final parts = item.split('|');
        if (parts[0] == widget.bookName &&
            parts[1] == widget.chapter.number.toString()) {
          bookmarkedIndexes.add(int.parse(parts[2]));
        }
      }
    });
  }

  Future<void> _saveHighlights() async {
    await prefs.setStringList(
      _highlightKey,
      highlightedIndexes.map((e) => e.toString()).toList(),
    );
  }

  Future<void> _saveNotes() async {
    final list = notes.entries.map((e) => '${e.key}|${e.value}').toList();
    await prefs.setStringList(_noteKey, list);
  }

  Future<void> _toggleBookmark(int index, String verseText) async {
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    final preview = verseText.split(' ').take(3).join(' ');
    final entry = '${widget.bookName}|${widget.chapter.number}|$index|$preview';

    setState(() {
      if (bookmarkedIndexes.contains(index)) {
        bookmarkedIndexes.remove(index);
        bookmarks.remove(entry);
      } else {
        bookmarkedIndexes.add(index);
        bookmarks.add(entry);
      }
    });

    await prefs.setStringList(_bookmarkKey, bookmarks);
  }

  void _toggleHighlight(int index) {
    setState(() {
      highlightedIndexes.contains(index)
          ? highlightedIndexes.remove(index)
          : highlightedIndexes.add(index);
    });
    _saveHighlights();
  }

  void _openNoteDialog(int index, {bool isEdit = false}) {
    final controller = TextEditingController(text: notes[index] ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEdit ? 'Edit Note' : 'Add Note'),
        content: TextFormField(
          controller: controller,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Write your note...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          if (isEdit)
            TextButton(
              onPressed: () {
                setState(() {
                  notes.remove(index);
                });
                _saveNotes();
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff1F3B96),
              ),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    notes[index] = controller.text.trim();
                  });
                  _saveNotes();
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotePopup(int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: MediaQuery.of(context).size.width - 32,
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notes[index] ?? '',
                  style: GoogleFonts.merriweather(fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pop(context);
                        _openNoteDialog(index, isEdit: true);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Color(0xffEB3D4D),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _openNoteDialog(index, isEdit: true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, int index, String verseText) {
    final width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: width*0.2,
            alignment: Alignment.center,
            color: Colors.blue.shade900,
            padding: const EdgeInsets.all(16),
            width: width,
            child: Wrap(
              spacing: 20,
              runSpacing: 12,
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>FullScreenVerseImage(
                    backgroundAsset: "assets/images/home_upper.png",
                    title: "${widget.bookName} ${widget.chapter.number}",
                    verseText: verseText
                  )))
                ),
                _optionTile(
                  icon: "assets/icons/highlight.svg",
                  title: highlightedIndexes.contains(index)
                      ? 'Remove Highlight'
                      : 'Highlight',
                  onTap: () {
                    _toggleHighlight(index);
                    Navigator.pop(context);
                  },
                ),
                _optionTile(
                  icon: "assets/images/notes.svg",
                  title: 'Note',
                  onTap: () {
                    Navigator.pop(context);
                    _openNoteDialog(index);
                  },
                ),
                _optionTile(
                  icon: "assets/icons/explore.svg",
                  title: 'Explore',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // // 🔹 FULL SCREEN IMAGE WITH BOOK NAME + CHAPTER + VERSE
  // void _showFullScreenVerseImage(int index, String verseText) {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black,
  //     builder: (_) => GestureDetector(
  //       onTap: () {
  //         SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //         Navigator.pop(context);
  //       },
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width,
  //         height: MediaQuery.of(context).size.height,
  //         child: RepaintBoundary(
  //           key: _imageKey,
  //           child: Stack(
  //             children: [
  //               Positioned.fill(
  //                 child: Image.asset(
  //                   "assets/images/morning_background.png",
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 left: 0,
  //                 right: 0,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       "${widget.bookName} ${widget.chapter.number}",
  //                       style: GoogleFonts.merriweather(
  //                         fontSize: 20,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       verseText,
  //                       style: GoogleFonts.merriweather(
  //                         fontSize: 25,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         shadows: const [
  //                           Shadow(
  //                             color: Colors.black87,
  //                             offset: Offset(2, 2),
  //                             blurRadius: 3,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   ).then((_) {
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   });
  // }

  Widget _optionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(icon, color: Colors.white),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              "${widget.bookName} ${widget.chapter.number}",
              style: GoogleFonts.merriweather(
                color: const Color(0xffB02626),
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.chapter.verses.length,
              itemBuilder: (context, index) {
                final verseText = widget.chapter.verses[index];
                final isHighlighted = highlightedIndexes.contains(index);
                final hasNote = notes.containsKey(index);
                final isBookmarked = bookmarkedIndexes.contains(index);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onLongPress: () => _showOptions(context, index, verseText),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? const Color(0xff8EDFB9)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: const Border(
                              left: BorderSide(
                                color: Color(0xffCDA434),
                                width: 5,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text("${index + 1}"),
                            title: Text(
                              verseText,
                              style: GoogleFonts.merriweather(fontSize: 14),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 4,
                          child: IconButton(
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.amber,
                            ),
                            onPressed: () => _toggleBookmark(index, verseText),
                          ),
                        ),
                        if (hasNote)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _showNotePopup(index),
                              child: SvgPicture.asset(
                                'assets/icons/desc.svg',
                                // ignore: deprecated_member_use
                                color: Colors.blueAccent.shade700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
