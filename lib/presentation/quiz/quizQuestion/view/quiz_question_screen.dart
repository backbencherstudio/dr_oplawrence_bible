import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/quiz_model.dart';
import '../../view/quiz_screen.dart';
import '../viewmodel/quiz_question_riverpod.dart';

class QuizQuestionScreen extends ConsumerWidget {
  final int level;
  const QuizQuestionScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider(level));
    final quizNotifier = ref.read(quizProvider(level).notifier);

    // Show loading spinner
    if (quizState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = quizState.quizModel?.questions ?? [];
    if (questions.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No questions available for this level.')),
      );
    }

    final currentQuestion = questions[quizState.currentQuestionIndex];

    void showSuccessDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Image.asset('assets/images/successfull.png'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(quizState),
              const SizedBox(height: 16),
              _buildQuestionCard(currentQuestion, quizState),
              const SizedBox(height: 24),
              ...List.generate(
                currentQuestion.options?.length ?? 0,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOptionButton(
                    currentQuestion.options![index],
                    index,
                    quizState,
                    () => quizNotifier.selectOption(index, showSuccessDialog),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(QuizState quizState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${quizState.currentQuestionIndex + 1}/${quizState.quizModel?.questions?.length ?? 0}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: quizState.progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Image.asset('assets/icons/slider.png', scale: 3),
      ],
    );
  }

  Widget _buildQuestionCard(Questions question, QuizState quizState) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${quizState.currentQuestionIndex + 1}/${quizState.quizModel?.questions?.length ?? 0}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            question.question ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
    String text,
    int index,
    QuizState quizState,
    VoidCallback onTap,
  ) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black87;

    if (quizState.isOptionSelected && quizState.selectedOptionIndex == index) {
      bgColor = Colors.green;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}