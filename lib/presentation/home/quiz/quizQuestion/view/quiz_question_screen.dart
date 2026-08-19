import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../viewmodel/quiz_question_riverpod.dart';
import 'widgets/quiz_question_card.dart';
import 'widgets/quiz_option_button.dart';
import 'widgets/quiz_success_dialog.dart';
import 'widgets/quiz_top_bar.dart';

class QuizQuestionScreen extends ConsumerWidget {
  const QuizQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    /// Loading
    if (quizState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final questions = quizState.quizModel?.questions ?? [];

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    final currentQuestion = questions.elementAt(quizState.currentQuestionIndex);
    final total = questions.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizTopBar(
                currentIndex: quizState.currentQuestionIndex,
                total: total,
                onBackTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.parentScreen,
                    (route) => false,
                  );
                },
              ),

              SizedBox(height: 16.h),

              QuizQuestionCard(
                number: quizState.currentQuestionIndex + 1,
                total: total,
                questionText: currentQuestion.question ?? "",
              ),

              SizedBox(height: 24.h),

              ...List.generate(
                currentQuestion.options?.length ?? 0,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: QuizOptionButton(
                    text: currentQuestion.options![index],
                    isSelected:
                        quizState.isOptionSelected &&
                        quizState.selectedOptionIndex == index,
                    isCorrect: quizState.isCorrectAns,
                    onTap: () => quizNotifier.selectOption(
                      index,
                      currentQuestion.id ?? '',
                      () => showQuizSuccessDialog(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}