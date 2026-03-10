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
class QuizStart {
  String? attemptId;
  String? quizId;
  int? totalQuestions;
  String? title;

  QuizStart({this.attemptId, this.quizId, this.totalQuestions, this.title});

  QuizStart.fromJson(Map<String, dynamic> json) {
    attemptId = json['attemptId'];
    quizId = json['quizId'];
    totalQuestions = json['totalQuestions'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attemptId'] = this.attemptId;
    data['quizId'] = this.quizId;
    data['totalQuestions'] = this.totalQuestions;
    data['title'] = this.title;
    return data;
  }
}

// ============== Quiz Attamped ============
// class QuizAttamped {
//   String? attemptId;
//   String? questionId;
//   int? selectedAnswer;

//   QuizAttamped({this.attemptId, this.questionId, this.selectedAnswer});

//   QuizAttamped.fromJson(Map<String, dynamic> json) {
//     attemptId = json['attemptId'];
//     questionId = json['questionId'];
//     selectedAnswer = json['selectedAnswer'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['attemptId'] = this.attemptId;
//     data['questionId'] = this.questionId;
//     data['selectedAnswer'] = this.selectedAnswer;
//     return data;
//   }
// }
