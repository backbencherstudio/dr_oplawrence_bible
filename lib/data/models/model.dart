class Model {
  String? attemptId;
  String? quizId;
  int? totalQuestions;
  String? title;

  Model({this.attemptId, this.quizId, this.totalQuestions, this.title});

  Model.fromJson(Map<String, dynamic> json) {
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
