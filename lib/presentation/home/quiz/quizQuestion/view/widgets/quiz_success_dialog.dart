import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/quiz_screen.dart';
import '../../viewmodel/quiz_question_riverpod.dart';

/// Shows the completion dialog after the last question is answered.
void showQuizSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const QuizSuccessDialogContent(),
  );
}

class QuizSuccessDialogContent extends ConsumerWidget {
  const QuizSuccessDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(quizProvider.notifier).levelChange();

              if (ref.read(quizProvider).quizLavel == 4) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ParentScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen()),
                );
              }
            },
            child: Image.asset('assets/images/successfull.png'),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}