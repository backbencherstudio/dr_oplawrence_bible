import 'package:dr_oplawrence_bible/presentation/quiz/quizQuestion/viewmodel/quiz_question_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../quizQuestion/view/quiz_question_screen.dart';



///  Convert StudyMoreScreen to ConsumerWidget to access providers
class StudyMoreScreen extends ConsumerWidget {
  const StudyMoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(quizProvider); // <-- read from provider

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        title: Text(
          'Study More',
          style: GoogleFonts.merriweather(
            color: const Color(0xFFC70039),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(height: 40.h),
              Expanded(
                child: ListView.separated(
                  itemCount: levels.levelList!.length,
                  separatorBuilder: (_, __) =>  SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final levelData = levels.levelList?[index];
                    return _buildLevelCard(
                      context,
                      levelData?.name??'',
                     levelData?.level??0,
                      levelData?.isUnlocked??false,
                    );
                  },
                ),
              ),
               SizedBox(height: 16.h),
              Text(
                'Keep playing to unlock more levels',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
               SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context,
    String levelName,
    int levelNumber,
    bool isUnlocked,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isUnlocked) return; // Locked level cannot be tapped
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizQuestionScreen(),
          ),
        );
      },
      child: Container(
        padding:  EdgeInsets.all(16.0.w),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.0.r),
          border: Border(
            left: BorderSide(
              color: isUnlocked ? const Color(0xffCDA434) : Colors.grey,
              width: 8,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              levelName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? Colors.black : Colors.grey.shade600,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                if (!isUnlocked) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuizQuestionScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding:  EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                side: BorderSide(
                  color: isUnlocked ? const Color(0xffCDA434) : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  color: isUnlocked ? const Color(0xffCDA434) : Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}