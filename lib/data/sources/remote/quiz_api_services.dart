import 'dart:developer';

import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';
import 'package:dr_oplawrence_bible/data/models/quiz_model.dart';

class QuizApiService {
  final ApiClient remote;

  QuizApiService({required this.remote});

  Future<QuizModel> quizQuestion(int level) async {
    final response = await remote.getRequest(
      endpoints: ApiEndpoints.quizQuestion(level),
    );

    if (response is List && response.isNotEmpty) {
      return QuizModel.fromJson(response[0]); // Take first quiz
    } else {
      throw Exception("Quiz not found for level $level");
    }
  }

  // =========== quiz start ===========
  Future<QuizStartModel> startQuiz({required String quizId}) async {
    final body = {"quizId": quizId};
    final response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.quizStart,
      body: body,
    );

   
      return QuizStartModel.fromJson(response);
   
  }

  // ============== Quiz Answer Attempted ==================
  Future<QuizAnsModel> quizAnsAttempt({
    required String attemptId,
    required String questionId,
    required int selectedAnswer,
  }) async {
    final body = {
      "attemptId": attemptId,
      "questionId": questionId,
      "selectedAnswer": selectedAnswer,
    };

    log(body.toString());
    final response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.quizAttemAnswer,
      body: body,
    );
   
      return QuizAnsModel.fromJson(response);
     
  }

  // ============== Quiz Get Attempt Final Result ===================
  Future<QuizGetAttamped> getQuizAttempt(String attemptId) async {
    final response = await remote.getRequest(
      endpoints: ApiEndpoints.quizAttempt(
        attemptId,
      ), 
    );
return QuizGetAttamped.fromJson(response);
    
  }
}
