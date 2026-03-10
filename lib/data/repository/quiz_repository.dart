

import 'package:dr_oplawrence_bible/data/sources/remote/quiz_api_services.dart' show QuizApiService;

import '../models/quiz_model.dart';

class QuizRepository {
  final QuizApiService apiService;

  QuizRepository({required this.apiService});
  Future<QuizModel> quizQuestion(int level) async{
    return await apiService.quizQuestion(level);
  }
  // =========== Quiz Start ==============
  Future<dynamic> startQuiz({required String quizId}) async {
    return await apiService.startQuiz(quizId: quizId);
  }
  
  
}