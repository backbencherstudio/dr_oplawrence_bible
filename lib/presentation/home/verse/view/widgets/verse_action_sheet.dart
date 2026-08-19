import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shows the top-aligned action sheet with verse options.
void showVerseActionSheet({
  required BuildContext context,
  required String verseText,
  required bool isHighlighted,
  required VoidCallback onCopy,
  required VoidCallback onImage,
  required VoidCallback onToggleHighlight,
  required VoidCallback onBookmark,
  required VoidCallback onNote,
  required VoidCallback onExplore,
}) {
  final width = MediaQuery.of(context).size.width;

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
              VerseActionTile(
                icon: "assets/icons/copy.svg",
                title: 'Copy',
                onTap: () {
                  onCopy();
                  Navigator.pop(context);
                },
              ),
              VerseActionTile(
                icon: "assets/icons/image.svg",
                title: 'Image',
                onTap: () {
                  Navigator.pop(context);
                  onImage();
                },
              ),
              VerseActionTile(
                icon: "assets/icons/highlight.svg",
                title: isHighlighted ? 'Remove' : 'Highlight',
                onTap: () {
                  onToggleHighlight();
                  Navigator.pop(context);
                },
              ),
              VerseActionTile(
                icon: "assets/icons/multiple.svg",
                title: 'Bookmark',
                onTap: () {
                  Navigator.pop(context);
                  onBookmark();
                },
              ),
              VerseActionTile(
                icon: "assets/images/notes.svg",
                title: 'Note',
                onTap: () {
                  Navigator.pop(context);
                  onNote();
                },
              ),
              VerseActionTile(
                icon: "assets/icons/explore.svg",
                title: 'Explore',
                onTap: () {
                  Navigator.pop(context);
                  onExplore();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Shows a saved note in a top-aligned popup.
void showVerseNotePopup(BuildContext context, String note) {
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
            note,
            style: GoogleFonts.merriweather(fontSize: 14),
          ),
        ),
      ),
    ),
  );
}

/// A single icon + label option used inside the verse action sheet.
class VerseActionTile extends StatelessWidget {
  const VerseActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
}