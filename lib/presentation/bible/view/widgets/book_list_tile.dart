import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constansts/color_manager.dart';
import '../../../../data/models/bible_model.dart';
import '../../viewmodel/bible_books_riverpod.dart';

class BookListTile extends ConsumerWidget {
  const BookListTile({
    super.key,
    required this.book,
    required this.isSelected,
    required this.progressMap,
    required this.calculateProgress,
    required this.onTap,
  });

  final BibleBook book;
  final bool isSelected;
  final Map<String, Set<String>> progressMap;
  final double Function(
    String bookId,
    int totalChapters,
    Map<String, Set<String>> progressMap,
  )
  calculateProgress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapterCountAsync = ref.watch(bookChapterCountProvider(book.id));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.deepAmber : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: chapterCountAsync.when(
          loading: () => ListTile(
            title: Text(book.name),
            trailing: const CircularProgressIndicator(),
          ),
          error: (e, _) =>
              ListTile(title: Text(book.name), subtitle: const Text("Error")),
          data: (totalChapters) {
            final percent = calculateProgress(
              book.id,
              totalChapters,
              progressMap,
            );

            return ListTile(
              title: Text(
                book.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? ColorsManager.whiteColor
                      : ColorsManager.blackColor,
                ),
              ),
              trailing: Text(
                "${percent.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? ColorsManager.whiteColor
                      : ColorsManager.deepAmber,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
