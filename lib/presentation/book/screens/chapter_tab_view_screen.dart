import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../book_screen.dart';

class ChapterTabView extends StatefulWidget {
  final BibleBook book;
  final Function(Chapter) onSelectChapter;

  const ChapterTabView({
    required this.book,
    required this.onSelectChapter,
    super.key,
  });

  @override
  State<ChapterTabView> createState() => _ChapterTabViewState();
}

class _ChapterTabViewState extends State<ChapterTabView> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "${widget.book.name} ${widget.book.chapters.length}",
            style: GoogleFonts.merriweather(
              color: const Color(0xffB02626),
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: widget.book.chapters.length,
              itemBuilder: (context, index) {
                final chapter = widget.book.chapters[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () async {
                    setState(() => selectedIndex = index);
                    await Future.delayed(const Duration(milliseconds: 500));

                    widget.onSelectChapter(chapter);
                    setState(() => selectedIndex = null);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xffCDA434) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : Text("${chapter.number}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}