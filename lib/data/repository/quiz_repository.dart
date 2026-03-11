import 'package:dr_oplawrence_bible/data/sources/remote/quiz_api_services.dart'
    show QuizApiService;

import '../models/quiz_model.dart';

class QuizRepository {
  final QuizApiService apiService;

  QuizRepository({required this.apiService});
  Future<QuizModel> quizQuestion(int level) async {
    return await apiService.quizQuestion(level);
  }

  // =========== Quiz Start ==============
  Future<QuizStartModel> startQuiz({required String quizId}) async {
    return await apiService.startQuiz(quizId: quizId);
  }

  // ========= Quiz Answer Attempted =====
  Future<QuizAnsModel> quizAnsAttempt({
    required String attemptId,
    required String questionId,
    required int selectedAnswer,
  }) async {
    return await apiService.quizAnsAttempt(
      attemptId: attemptId,
      questionId: questionId,
      selectedAnswer: selectedAnswer,
    );
  }
  // ============== Quiz Get Attempt Final Answer ===================
  Future<QuizGetAttamped> getQuizAttempt({required String attemptId}) async {
    return await apiService.getQuizAttempt(attemptId);
  }
}
