import 'dart:developer';
import '../models/quiz_model.dart';
import '../../core/network/api_clients.dart';
import '../../core/network/api_endpoints.dart';
import '../sources/local/shared_preference/shared_preference.dart';

class QuizRepository {
  /// Fetch quiz questions by level
  Future<List<QuizModel>> getQuiz(int level) async {
    try {
      // Get token from SharedPreferences
      final token = await SharedPreferenceData.getToken();

      if (token == null) {
        log("No token found. User must login first.");
        return [];
      }

      // Set token in headers
      await ApiClient.headerSet(token);

      // Call API
      final response = await ApiClient().getRequest(
        endpoints: ApiEndpoints.quizQuestion(level),
      );

      log("Raw API Response: $response");

      if (response is List && response.isNotEmpty) {
        final quizList = response
            .map((e) => QuizModel.fromJson(e as Map<String, dynamic>))
            .toList();

        log("Quiz Parsed Successfully: ${quizList.length} quizzes");
        return quizList;
      } else {
        log("No quiz available for this level");
        return [];
      }
    } catch (e) {
      log("Error fetching quiz: $e");
      return [];
    }
  }
}