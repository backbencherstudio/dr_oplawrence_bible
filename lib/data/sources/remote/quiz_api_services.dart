import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';
import 'package:dr_oplawrence_bible/data/models/quiz_model.dart';

class QuizApiService {
  final ApiClient remote;

  QuizApiService({required this.remote,});

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
  Future<dynamic> startQuiz({required String quizId}) async {
    final body = {"quizId": quizId};
    final response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.quizStart,
      body: body,
    );
    if (response['success'] == true) {
      return response;
    } else {
      throw Exception(response['message'] ?? 'Failed to start quiz attempt');
    }
  }
  
}
