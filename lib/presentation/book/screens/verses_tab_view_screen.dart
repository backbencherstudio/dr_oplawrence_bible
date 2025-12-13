import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
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
  final Set<int> highlightedIndexes = {};
  final Map<int, String> notes = {};
  late SharedPreferences prefs;

  String get _highlightKey =>
      'highlight_${widget.bookName}_${widget.chapter.number}';

  String get _noteKey =>
      'notes_${widget.bookName}_${widget.chapter.number}';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    prefs = await SharedPreferences.getInstance();

    final highlights = prefs.getStringList(_highlightKey) ?? [];
    final notesMap = prefs.getStringList(_noteKey) ?? [];

    setState(() {
      highlightedIndexes
          .addAll(highlights.map((e) => int.parse(e)));

      for (var item in notesMap) {
        final parts = item.split('|');
        notes[int.parse(parts[0])] = parts[1];
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
    final list = notes.entries
        .map((e) => '${e.key}|${e.value}')
        .toList();
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

  void _openNoteDialog(int index, {bool isEdit = false}) {
    final controller =
    TextEditingController(text: notes[index] ?? '');

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
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(width: double.infinity,
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
                      icon:
                      const Icon(Icons.delete_forever_outlined, color: Color(0xffEB3D4D)),
                      onPressed: () {
                        Navigator.pop(context);
                        _openNoteDialog(index, isEdit: true);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, int index, String verseText) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Container(color: Color(0xff262626),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width - 32,
            child: Wrap(
              spacing: 20,
              runSpacing: 12,
              children: [
                _optionTile(
                  icon: "assets/icons/copy.svg",
                  title: 'Copy',
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: verseText));
                    Navigator.pop(context);
                  },
                ),
                _optionTile(
                  icon: "assets/icons/image.svg",
                  title: 'Image',
                  onTap: () => Navigator.pop(context),
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
                  icon: "assets/icons/multiple.svg",
                  title: 'Multiple',
                  onTap: () => Navigator.pop(context),
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


  Widget _optionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         SvgPicture.asset(icon,color: Colors.white,),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12,color: Colors.white)),
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
      
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onLongPress: () =>
                        _showOptions(context, index, verseText),
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
                        if (hasNote)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _showNotePopup(index),
                              child: SvgPicture.asset('assets/icons/desc.svg',color: Colors.blueAccent.shade700,)
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
