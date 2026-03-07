class QuizModel {
  final String id;
  final String title;
  final String description;
  final int level;
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      level: json['level'],
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }
}

class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final String explaination;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.explaination,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      explaination: json['explanation'],
    );
  }
}