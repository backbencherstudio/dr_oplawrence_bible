import 'dart:async';
import 'package:dr_oplawrence_bible/data/repository/quiz_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/network/api_clients.dart';
import '../../../../../data/models/quiz_model.dart';
import '../../../../../data/sources/remote/quiz_api_services.dart';

class LevelModel {
  final String name;
  final int level;
  final bool isUnlocked;

  LevelModel({
    required this.name,
    required this.level,
    required this.isUnlocked,
  });

  LevelModel copyWith({bool? isUnlocked}) {
    return LevelModel(
      name: name,
      level: level,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

class QuizState {
  final QuizModel? quizModel;
  final QuizStartModel? quizStartModel;
  final int currentQuestionIndex;
  final int quizLavel;
  final int selectedOptionIndex;
  final bool isOptionSelected;
  final double progress;
  final bool isLoading;
  final bool isCorrectAns;
  List<LevelModel>? levelList;
  final int score;

  QuizState({
    this.quizModel,
    this.quizStartModel,
    this.currentQuestionIndex = 0,
    this.quizLavel = 1,
    this.selectedOptionIndex = -1,
    this.isOptionSelected = false,
    this.progress = 0.0,
    this.isLoading = true,
    this.isCorrectAns = false,
    this.levelList,
    this.score = 0,
  });

  QuizState copyWith({
    QuizModel? quizModel,
    QuizStartModel? quizStartModel,
    int? currentQuestionIndex,
    int? selectedOptionIndex,
    bool? isOptionSelected,
    double? progress,
    bool? isLoading,
    int? quizLavel,
    bool? isCorrectAns,
    List<LevelModel>? levelList,
    int? score,
  }) {
    return QuizState(
      quizModel: quizModel ?? this.quizModel,
      quizStartModel: quizStartModel ?? this.quizStartModel,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      isOptionSelected: isOptionSelected ?? this.isOptionSelected,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      quizLavel: quizLavel ?? this.quizLavel,
      isCorrectAns: isCorrectAns ?? this.isCorrectAns,
      levelList: levelList ?? this.levelList,
      score: score ?? this.score,
    );
  }
}

/// StateNotifier to handle quiz logic
class QuizNotifier extends StateNotifier<QuizState> {
  final QuizApiService apiService = QuizApiService(remote: ApiClient());

  QuizNotifier()
    : super(
        QuizState(
          levelList: [
            LevelModel(name: 'Level 1', level: 1, isUnlocked: false),
            LevelModel(name: 'Level 2', level: 2, isUnlocked: false),
            LevelModel(name: 'Level 3', level: 3, isUnlocked: false),
          ],
        ),
      ) {
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    try {
      final quiz = await apiService.quizQuestion(state.quizLavel);
      state = state.copyWith(quizModel: quiz, isLoading: false);
      await startQuizAttempt();
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
      print(
        "=============$quizId======================================Quiz attempt started: ${response.attemptId}",
      );
      state = state.copyWith(quizStartModel: response);
    } catch (e) {
      print("Failed to start quiz attempt: $e");
    }
  }

  // ========== Quiz Answer Attemped ================
  Future<bool> quizAnswerAttemp(int selectionAns, String questionId) async {
    if (state.quizStartModel == null) return false;
    final attamp = state.quizStartModel!.attemptId!;
    // final quiz = state.quizStartModel!.quizId!;
    // final selectionNumber = state.quizStartModel!.totalQuestions!;
    try {
      final response = await apiService.quizAnsAttempt(
        attemptId: attamp,
        questionId: questionId,
        selectedAnswer: selectionAns,
      );
      print('Quiz answer Attempted: $response');
      state = state.copyWith(isCorrectAns: response.isCorrect ?? false);
      return response.isCorrect ?? false;
    } catch (e) {
      return false;
    }
  }

  // ================== Quiz Get Attempted Total Question Mark =============
  Future<void> getQuizAttempt() async {
    if (state.quizStartModel == null) return;

    final attemptId = state.quizStartModel!.attemptId!;

    try {
      final result = await apiService.getQuizAttempt(attemptId);

      state = state.copyWith(score: result.score ?? 0);

      print("Final Score: ${result.score}");
    } catch (e) {
      print("Error getting result: $e");
    }
  }

  Future<void> selectOption(
    int index,
    String questionId,
    Function showSuccessDialog,
  ) async {
    if (state.isOptionSelected) return;

    state = state.copyWith(selectedOptionIndex: index, isOptionSelected: true);

    await quizAnswerAttemp(index + 1, questionId);

    Timer(const Duration(seconds: 1), () async {
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
        await getQuizAttempt();
        showSuccessDialog();
      }
    });
  }

  levelChange() {
    if (state.quizLavel < 3) {
      //  unlockNextLevel( state.quizLavel);
      state = state.copyWith(
        quizLavel: state.quizLavel + 1,
        currentQuestionIndex: 0,
        isOptionSelected: false,
        selectedOptionIndex: -1,
        progress: 0,
      );
      loadQuiz();
      unlockNextLevel(state.quizLavel);
    } else {
      state = state.copyWith(quizLavel: 4);
    }
  }

  void unlockNextLevel(int index) {
    final updatedLevels = state.levelList!.map((level) {
      if (level.level == index) {
        return level.copyWith(isUnlocked: true);
      }
      if (level.level == index - 1) {
        return level.copyWith(isUnlocked: false);
      }
      return level;
    }).toList();

    state = state.copyWith(levelList: updatedLevels);
  }
}

// /// Provider with dynamic level
final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(),
);

// final quizAttemptProvider = FutureProvider.family<QuizGetAttamped, String>((
//   ref,
//   attemptId,
// ) async {
//   final repository = QuizRepository(
//     apiService: QuizApiService(remote: ApiClient()),
//   );
//   return await repository.getQuizAttempt(attemptId: attemptId);
// });

final quizRepositoryAns = Provider((ref) {
  return QuizRepository(apiService: QuizApiService(remote: ApiClient()));
});
final quizFinalScopre = FutureProvider.family<QuizGetAttamped, String>((
  ref,
  attemptId,
) async {
  final repo = ref.read(quizRepositoryAns);
  return repo.getQuizAttempt(attemptId: attemptId);
});
