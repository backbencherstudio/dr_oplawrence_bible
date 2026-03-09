import '../models/quiz_model.dart';
import '../sources/remote/quiz_api_services.dart';

class QuizRepository {
  final QuizApiService apiService;

  QuizRepository({required this.apiService});
  Future<QuizModel> quizQuestion(int level) async{
    return await apiService.quizQuestion(level);
  }

  
}