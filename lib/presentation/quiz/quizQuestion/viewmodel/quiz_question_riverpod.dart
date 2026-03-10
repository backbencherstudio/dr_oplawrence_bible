import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../data/models/quiz_model.dart';
import '../../../../data/sources/remote/quiz_api_services.dart';

/// State class to hold quiz info
class QuizState {
  final QuizModel? quizModel;
  final int currentQuestionIndex;
  final int selectedOptionIndex;
  final bool isOptionSelected;
  final double progress;
  final bool isLoading;

  QuizState({
    this.quizModel,
    this.currentQuestionIndex = 0,
    this.selectedOptionIndex = -1,
    this.isOptionSelected = false,
    this.progress = 0.0,
    this.isLoading = true,
  });

  QuizState copyWith({
    QuizModel? quizModel,
    int? currentQuestionIndex,
    int? selectedOptionIndex,
    bool? isOptionSelected,
    double? progress,
    bool? isLoading,
  }) {
    return QuizState(
      quizModel: quizModel ?? this.quizModel,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      isOptionSelected: isOptionSelected ?? this.isOptionSelected,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// StateNotifier to handle quiz logic
class QuizNotifier extends StateNotifier<QuizState> {
  final int level;
  final QuizApiService apiService = QuizApiService(remote: ApiClient());

  QuizNotifier(this.level) : super(QuizState()) {
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      final quiz = await apiService.quizQuestion(level);
      state = state.copyWith(quizModel: quiz, isLoading: false);
    } catch (e) {
      print('Error loading quiz: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// New: send quizId to start attempt
  Future<void> startQuizAttempt() async {
    if (state.quizModel == null) return;
    final quizId = state.quizModel!.id!;
    try {
      final response = await apiService.startQuiz(quizId: quizId);
      print("Quiz attempt started: $response");
    } catch (e) {
      print("Failed to start quiz attempt: $e");
    }
  }

  void selectOption(int index, Function showSuccessDialog) {
    if (state.isOptionSelected) return;

    state = state.copyWith(selectedOptionIndex: index, isOptionSelected: true);

    // Start quiz attempt only on first option tap
    startQuizAttempt();

    Timer(const Duration(seconds: 1), () {
      final totalQuestions = state.quizModel?.questions?.length ?? 1;
      final nextIndex = state.currentQuestionIndex + 1;

      if (nextIndex < totalQuestions) {
        state = state.copyWith(
          currentQuestionIndex: nextIndex,
          selectedOptionIndex: -1,
          isOptionSelected: false,
          progress: nextIndex / totalQuestions,
        );
      } else {
        showSuccessDialog();
      }
    });
  }
}

/// Provider with dynamic level
final quizProvider = StateNotifierProvider.family<QuizNotifier, QuizState, int>( (ref, level) => QuizNotifier(level), );

