import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';
import 'package:dr_oplawrence_bible/data/models/quiz_model.dart';


class QuizApiService {ApiClient remote;
QuizApiService({required this.remote});
Future<QuizModel> quizQuestion(int level) async{
  final response = await remote.getRequest(endpoints:ApiEndpoints.quizQuestion(level));
  return QuizModel.fromJson(response);
}
 
}