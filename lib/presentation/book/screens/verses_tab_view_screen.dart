import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../book_screen.dart';

class VerseTabView extends StatelessWidget {
  final Chapter chapter;
  final String bookName;

  const VerseTabView({
    required this.chapter,
    required this.bookName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "$bookName ${chapter.number}",
            style: GoogleFonts.merriweather(
              color: const Color(0xffB02626),
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chapter.verses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: const Border(
                      left: BorderSide(color: Color(0xffCDA434), width: 5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(chapter.verses[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
