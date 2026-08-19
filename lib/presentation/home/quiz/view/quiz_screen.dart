import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:dr_oplawrence_bible/presentation/home/quiz/studyMore/view/study_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/quiz_app_bar.dart';
import 'widgets/quiz_challenges_card.dart';
import 'widgets/quiz_jigsaw_puzzle_grid.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      appBar: QuizAppBar(
        onBack: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ParentScreen()),
        ),
        action: const Icon(Icons.school, color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const QuizJigsawPuzzleGrid(),
            SizedBox(height: 30.h),
            QuizChallengesCard(
              onStart: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StudyMoreScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}