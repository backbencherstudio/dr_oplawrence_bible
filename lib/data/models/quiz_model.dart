// ============== Quiz Model =================
class QuizModel {
  String? id;
  String? title;
  String? description;
  int? level;
  List<Questions>? questions;

  QuizModel({
    this.id,
    this.title,
    this.description,
    this.level,
    this.questions,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    level = json['level'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['level'] = level;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? question;
  List<String>? options;
  String? explanation;

  Questions({this.id, this.question, this.options, this.explanation});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['explanation'] = explanation;
    return data;
  }
}

// ============ Start Quiz Model =============
class QuizStartModel {
  String? attemptId;
  String? quizId;
  int? totalQuestions;
  String? title;

  QuizStartModel({
    this.attemptId,
    this.quizId,
    this.totalQuestions,
    this.title,
  });

  QuizStartModel.fromJson(Map<String, dynamic> json) {
    attemptId = json['attemptId'];
    quizId = json['quizId'];
    totalQuestions = json['totalQuestions'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['attemptId'] = this.attemptId;
    data['quizId'] = this.quizId;
    data['totalQuestions'] = this.totalQuestions;
    data['title'] = this.title;
    return data;
  }
}

// ============== Quiz get Attamped ============
class QuizGetAttamped {
  String? id;
  String? quizId;
  String? userId;
  int? totalQuestions;
  int? correctAnswers;
  int? score;
  String? completedAt;
  List<Answers>? answers;

  QuizGetAttamped.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quizId'];
    userId = json['userId'];
    totalQuestions = json['totalQuestions'];
    correctAnswers = json['correctAnswers'];
    score = json['score'];
    completedAt = json['completedAt'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }
}

class Answers {
  String? questionId;
  String? question;
  int? selectedAnswer;
  bool? isCorrect;
  int? correctAnswer;
  List<String>? options;
  String? explanation;

  Answers({
    this.questionId,
    this.question,
    this.selectedAnswer,
    this.isCorrect,
    this.correctAnswer,
    this.options,
    this.explanation,
  });

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    selectedAnswer = json['selectedAnswer'];
    isCorrect = json['isCorrect'];
    correctAnswer = json['correctAnswer'];
    options = json['options'].cast<String>();
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['question'] = this.question;
    data['selectedAnswer'] = this.selectedAnswer;
    data['isCorrect'] = this.isCorrect;
    data['correctAnswer'] = this.correctAnswer;
    data['options'] = this.options;
    data['explanation'] = this.explanation;
    return data;
  }
}

// ============= Quiz Attempted Answer ==============
class QuizAnsModel {
  String? questionId;
  bool? isCorrect;
  int? correctAnswer;
  String? explanation;

  QuizAnsModel({
    this.questionId,
    this.isCorrect,
    this.correctAnswer,
    this.explanation,
  });

  QuizAnsModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    isCorrect = json['isCorrect'];
    correctAnswer = json['correctAnswer'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questionId'] = questionId;
    data['isCorrect'] = isCorrect;
    data['correctAnswer'] = correctAnswer;
    data['explanation'] = explanation;
    return data;
  }
}
