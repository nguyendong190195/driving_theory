class DataTopic {
  List<Data> data;

  DataTopic({this.data});

  DataTopic.fromJson(Map<String, dynamic> json) {
    if (json!= null) {
      if (json['data'] != null) {
        data = new List<Data>();
        json['data'].forEach((v) {
          data.add(new Data.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String topic;
  List<ListQuestion> listQuestion;

  Data({this.topic, this.listQuestion});

  Data.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    if (json['listQuestion'] != null) {
      listQuestion = new List<ListQuestion>();
      json['listQuestion'].forEach((v) {
        listQuestion.add(new ListQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = this.topic;
    if (this.listQuestion != null) {
      data['listQuestion'] = this.listQuestion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListQuestion {
  String questionEn;
  String questionVi;
  String questionCode;
  List<Answers> answers;

  ListQuestion(
      {this.questionEn, this.questionVi, this.questionCode, this.answers});

  ListQuestion.fromJson(Map<String, dynamic> json) {
    questionEn = json['question_en'];
    questionVi = json['question_vi'];
    questionCode = json['question_code'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_en'] = this.questionEn;
    data['question_vi'] = this.questionVi;
    data['question_code'] = this.questionCode;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String answerEn;
  String answerVi;
  String answerCode;
  bool correct;

  Answers({this.answerEn, this.answerVi, this.answerCode, this.correct});

  Answers.fromJson(Map<String, dynamic> json) {
    answerEn = json['answer_en'];
    answerVi = json['answer_vi'];
    answerCode = json['answer_code'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_en'] = this.answerEn;
    data['answer_vi'] = this.answerVi;
    data['answer_code'] = this.answerCode;
    data['correct'] = this.correct;
    return data;
  }
}