import 'package:dr_oplawrence_bible/data/models/bible_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'verse_card.dart';

/// Reusable scrollable list of verses with highlight / note overlays.
class VerseList extends StatelessWidget {
  const VerseList({
    super.key,
    required this.future,
    required this.highlightedIndexes,
    required this.noteIndexes,
    required this.onVerseLongPress,
    required this.onNoteTap,
  });

  final Future<List<BibleVerse>> future;
  final Set<int> highlightedIndexes;
  final Set<int> noteIndexes;
  final void Function(BibleVerse verse, int index) onVerseLongPress;
  final void Function(int index) onNoteTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BibleVerse>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No verses found.'));
        }

        final verses = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final verse = verses[index];
            final hasNote = noteIndexes.contains(index);
            final isHighlighted = highlightedIndexes.contains(index);

            return GestureDetector(
              onLongPress: () => onVerseLongPress(verse, index),
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
                        onTap: () => onNoteTap(index),
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
    );
  }
}