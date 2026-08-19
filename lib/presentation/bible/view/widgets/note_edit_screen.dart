import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable screen for editing a note attached to a verse.
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
        child: SingleChildScrollView(
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
                    color: const Color(0xFFB71C1C),
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
                    color: const Color(0xFFD9D9D9),
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
                          color: const Color(0xFF424242),
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // --- UPDATED EDITING FIELD ---
                Container(
                  height: 220.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "I love this reading...",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.w),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
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
      ),
    );
  }
}