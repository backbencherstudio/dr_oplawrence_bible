import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable 2x2 jigsaw puzzle grid with the first piece unlocked.
class QuizJigsawPuzzleGrid extends StatelessWidget {
  const QuizJigsawPuzzleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => QuizPuzzlePiece(index: index),
        ),
      ),
    );
  }
}

/// A single jigsaw puzzle piece; locked unless it's the first index.
class QuizPuzzlePiece extends StatelessWidget {
  const QuizPuzzlePiece({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isLocked = index != 0;

    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (index == 0)
            Image.asset('assets/images/quiz_background.png', fit: BoxFit.cover),
          if (isLocked)
            Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/quiz_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(decoration: BoxDecoration(color: Colors.white38)),
                  Center(
                    child: Image.asset('assets/icons/lock.png', scale: 3),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}