
class Quiz {
  int? responseCode;
  List<Results>? results;

  Quiz({this.responseCode, this.results});

  Quiz.fromJson(Map<String, dynamic> json) {
    responseCode = json["response_code"];
    results = json["results"] == null ? null : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
  }

  static List<Quiz> fromList(List<Map<String, dynamic>> list) {
    return list.map(Quiz.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["response_code"] = responseCode;
    if(results != null) {
      _data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Results {
  String? type;
  String? difficulty;
  String? category;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Results({this.type, this.difficulty, this.category, this.question, this.correctAnswer, this.incorrectAnswers});

  Results.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    difficulty = json["difficulty"];
    category = json["category"];
    question = json["question"];
    correctAnswer = json["correct_answer"];
    incorrectAnswers = json["incorrect_answers"] == null ? null : List<String>.from(json["incorrect_answers"]);
  }

  static List<Results> fromList(List<Map<String, dynamic>> list) {
    return list.map(Results.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["difficulty"] = difficulty;
    _data["category"] = category;
    _data["question"] = question;
    _data["correct_answer"] = correctAnswer;
    if(incorrectAnswers != null) {
      _data["incorrect_answers"] = incorrectAnswers;
    }
    return _data;
  }
}