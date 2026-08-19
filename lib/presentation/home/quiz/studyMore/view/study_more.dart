import 'package:dr_oplawrence_bible/presentation/home/quiz/quizQuestion/view/quiz_question_screen.dart';
import 'package:dr_oplawrence_bible/presentation/home/quiz/quizQuestion/viewmodel/quiz_question_riverpod.dart';
import 'package:dr_oplawrence_bible/presentation/home/quiz/view/widgets/quiz_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/level_card.dart';

/// Screen listing the study levels and their unlocked status.
class StudyMoreScreen extends ConsumerWidget {
  const StudyMoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(quizProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: QuizAppBar(
        title: 'Study More',
        onBack: () => Navigator.pop(context),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Expanded(
                child: ListView.separated(
                  itemCount: levels.levelList?.length ?? 0,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final level = levels.levelList?[index];
                    return LevelCard(
                      levelName: level?.name ?? '',
                      isUnlocked: level?.isUnlocked ?? false,
                      onStart: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizQuestionScreen(),
                          ),
                        );
                      },
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
}