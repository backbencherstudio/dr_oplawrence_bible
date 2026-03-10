import 'package:dr_oplawrence_bible/data/models/quiz_model.dart';
import 'package:dr_oplawrence_bible/data/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class QuizViewModel extends ChangeNotifier{
  final QuizRepository repository;
   QuizViewModel({required this.repository});
   QuizModel? quizModel;
   Future<void> loadQuiz(int level) async{
    quizModel = await repository.quizQuestion(level);
    notifyListeners();
   }
}