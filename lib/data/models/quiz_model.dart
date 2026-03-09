class QuizModel {
  String? id;
  String? title;
  String? description;
  int? level;
  List<Questions>? questions;

  QuizModel(
      {this.id, this.title, this.description, this.level, this.questions});

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
    data['description'] =description;
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
    final Map<String, dynamic> data ={};
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['explanation'] = explanation;
    return data;
  }
}
