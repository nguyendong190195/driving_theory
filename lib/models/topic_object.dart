class DataTopic {
   String title;
   List<Data> data = <Data>[];

  DataTopic(this.title);

  DataTopic.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    if (json['title'] != null) {
      title = json['title'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.title != null) {
      data['title'] = this.title;
    }
    return data;
  }

  DataTopic clone() {
    DataTopic dataTopic = DataTopic('title');
    dataTopic.title = 'title';
    List<Data> listData = <Data>[];
    for(Data item in data) {
      listData.add(item.clone());
    }
    dataTopic.data = listData;
    return dataTopic;
  }
}

class Data {
   String topic;
   List<ListQuestion> listQuestion;

  Data(this.topic, this.listQuestion);

  Data clone() {
    Data data = Data(topic, listQuestion);
    data.topic = topic;
    List<ListQuestion> listDataQuestion = <ListQuestion>[];

    for (ListQuestion item in listQuestion) {
      listDataQuestion.add(item.clone());
    }
    data.listQuestion = listDataQuestion;
    return data;
  }

  Data.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    if (json['listQuestion'] != null) {
      listQuestion = <ListQuestion>[];
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
   bool isSelected = false;
   bool existCache = false;

  ListQuestion(this.questionEn);

  ListQuestion clone() {
    ListQuestion question = ListQuestion(questionEn);
    question.questionEn = questionEn;
    question.questionVi = questionVi;
    question.questionCode = questionCode;
    List<Answers> anserClone = <Answers>[];
    for (Answers item in answers) {
      item = item.clone();
      anserClone.add(item);
    }
    question.answers = anserClone;
    return question;
  }

  ListQuestion.fromJson(Map<String, dynamic> json) {
    questionEn = json['question_en'];
    questionVi = json['question_vi'];
    questionCode = json['question_code'];

    if (json['isSelected'] != null) isSelected = json['isSelected'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_en'] = this.questionEn;
    data['question_vi'] = this.questionVi;
    if (this.isSelected != null) {
      data['isSelected'] = this.isSelected;
    }
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
   bool isSelected = false;

  Answers clone() {
    Answers answersClone = new Answers(answerEn);
    answersClone.answerEn = answerEn;
    answersClone.answerVi = answerVi;
    answersClone.answerCode = answerCode;
    answersClone.correct = correct;
    answersClone.isSelected = isSelected;
    return answersClone;
  }

  Answers(this.answerEn);

  Answers.fromJson(Map<String, dynamic> json) {
    answerEn = json['answer_en'];
    answerVi = json['answer_vi'];
    answerCode = json['answer_code'];
    if (json['isSelected'] != null) {
      isSelected = json['isSelected'];
    }
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_en'] = this.answerEn;
    data['answer_vi'] = this.answerVi;
    data['answer_code'] = this.answerCode;
    data['correct'] = this.correct;
    data['isSelected'] = this.isSelected;

    return data;
  }
}
