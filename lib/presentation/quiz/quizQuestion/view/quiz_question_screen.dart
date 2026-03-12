import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/quiz_model.dart';
import '../../view/quiz_screen.dart';
import '../viewmodel/quiz_question_riverpod.dart';

class QuizQuestionScreen extends ConsumerWidget {
  const QuizQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    /// Loading
    if (quizState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = quizState.quizModel?.questions ?? [];

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    final currentQuestion =
        questions.elementAt(quizState.currentQuestionIndex);

    /// =========== Success Dialog =============
    // void showSuccessDialog() {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => AlertDialog(
    //       contentPadding: EdgeInsets.zero,
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //               Image.asset('assets/images/successfull.png'),
                 
    //            SizedBox(height: 10.h),
    //           ElevatedButton(
    //             onPressed: () {
    //               ref.read(quizProvider.notifier).levelChange();

    //               if (ref.read(quizProvider).quizLavel == 4) {
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (_) => ParentScreen(),
    //                   ),
    //                 );
    //               } else {
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (_) => QuizScreen(),
    //                   ),
    //                 );
    //               }
    //             },
    //             child: const Text("Continue"),
    //           ),
    //            SizedBox(height: 10.h),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    void showSuccessDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
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
                  MaterialPageRoute(
                    builder: (_) => ParentScreen(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(),
                  ),
                );
              }
            },
            child: Image.asset('assets/images/successfull.png'),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    ),
  );
}

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(quizState, context),

               SizedBox(height: 16.h),

              _buildQuestionCard(currentQuestion, quizState),

               SizedBox(height: 24.h),

              ...List.generate(
                currentQuestion.options?.length ?? 0,
                (index) => Padding(
                  padding:  EdgeInsets.only(bottom: 12.h),
                  child: _buildOptionButton(
                    currentQuestion.options![index],
                    index,
                    quizState,
                    () => quizNotifier.selectOption(
                      index,
                      currentQuestion.id ?? '',
                      showSuccessDialog,
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

  /// ================= APP BAR =================
  Widget _buildAppBar(QuizState quizState, BuildContext context) {
    final total = quizState.quizModel?.questions?.length ?? 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.parentScreen,
              (route) => false,
            );
          },
          child: Image.asset(
            'assets/icons/back_arrow.png',
            scale: 4,
          ),
        ),
         SizedBox(width: 16.w),

        Expanded(
          child: Column(
            children: [
              Text(
                "${quizState.currentQuestionIndex + 1}/$total",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),

               SizedBox(height: 6.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value:
                      (quizState.currentQuestionIndex + 1) / total,
                  minHeight: 8.h,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

         SizedBox(width: 16.w),

        Image.asset(
          'assets/icons/slider.png',
          scale: 3,
        ),
      ],
    );
  }

  /// ================= QUESTION CARD =================
  Widget _buildQuestionCard(
      Questions question, QuizState quizState) {
    final total = quizState.quizModel?.questions?.length ?? 0;

    return Container(
      padding:  EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${quizState.currentQuestionIndex + 1}/$total",
            style:  TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
           SizedBox(height: 10.h),
          Text(
            question.question ?? "",
            style:  TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= OPTION BUTTON =================
  Widget _buildOptionButton(
    String text,
    int index,
    QuizState quizState,
    VoidCallback onTap,
  ) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black87;

    if (quizState.isOptionSelected &&
        quizState.selectedOptionIndex == index) {
      if (quizState.isCorrectAns) {
        bgColor = Colors.green;
      } else {
        bgColor = Colors.red;
      }

      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}