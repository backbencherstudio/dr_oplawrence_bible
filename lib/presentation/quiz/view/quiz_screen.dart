import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:dr_oplawrence_bible/presentation/quiz/studyMore/view/study_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ParentScreen()),
          ),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        title: Text(
          'Quiz',
          style: GoogleFonts.merriweather(
            color: Color(0xFFC70039),
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: Icon(Icons.school, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildJigsawPuzzleGrid(),
             SizedBox(height: 30.h),
            _buildChallengesCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildJigsawPuzzleGrid() {
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
          itemBuilder: (context, index) {
            return _buildPuzzlePiece(index);
          },
        ),
      ),
    );
  }

  Widget _buildPuzzlePiece(int index) {
    bool isLocked = index != 0;
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
                  Center(child: Image.asset('assets/icons/lock.png', scale: 3)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChallengesCard(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Padding(
        padding:  EdgeInsets.all(24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              'Morning and Night Challenges',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 8.h),
             Text(
              'Pass morning and night Bible quiz challenge to unlock the jigsaw',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudyMoreScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCDA434),
                padding:  EdgeInsets.symmetric(vertical: 16.0.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),
              child:  Text(
                'Start',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

