import 'package:driving_theory/extension/circular_percent_indicator.dart';
import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab1/review_question_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PracticeAllQuestionScreen extends StatefulWidget {
  DataTopic dataTopic;
  late List<ListQuestion> listQuestionCache;
  Data? listCacheSave;

  PracticeAllQuestionScreen(this.dataTopic, this.listCacheSave);

  @override
  State<StatefulWidget> createState() {
    return _PracticeAllQuestionState();
  }
}

class _PracticeAllQuestionState extends State<PracticeAllQuestionScreen> {
  bool hasRunViewDidAppearThisAppOpening = false;

  @override
  Widget build(BuildContext context) {
    if (widget.listCacheSave != null &&
        widget.listCacheSave!.listQuestion != null &&
        !widget.listCacheSave!.listQuestion.isEmpty) {
      return MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Practice all questions'),
              backgroundColor: HexColor.mainColor(),
              centerTitle: true,
              bottom: TabBar(
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                unselectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(
                      child: Text(
                    'All practice',
                    textAlign: TextAlign.start,
                  )),
                  Tab(
                      child: Text(
                    'Flagged Questions',
                    textAlign: TextAlign.start,
                  )),
                ],
              ),
            ),
            body: TabBarView(children: [
              Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        gotoReviewScreen(widget.dataTopic, index);
                      },
                      child: buildCardItem(index),
                    );
                  },
                  itemCount: widget.dataTopic.data.length,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return buildItemReview(index);
                    },
                    itemCount: widget.listCacheSave!.listQuestion.length,
                  ))
            ]),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Practice all questions'),
          backgroundColor: HexColor.mainColor(),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  gotoReviewScreen(widget.dataTopic, index);
                },
                child: buildCardItem(index),
              );
            },
            itemCount: widget.dataTopic.data.length,
          ),
        ),
      );
    }
  }

  Widget buildItemReview(int index) {
    ListQuestion question = widget.listCacheSave!.listQuestion[index];
    return Container(
      child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowInQuestion(question, index),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getItemAnswer(question, 0),
                  getItemAnswer(question, 1),
                  getItemAnswer(question, 2),
                  getItemAnswer(question, 3),
                ],
              ),
            ],
          )),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 1.0,
          ),
        ],
      ),
    );
  }

  Widget getItemAnswer(ListQuestion question, int numAnswer) {
    if (question.answers[numAnswer].answerCode == null ||
        question.answers[numAnswer].answerCode.isEmpty) {
      return GestureDetector(
        onTap: () {
          if (!question.isSelected) {
            question.answers[numAnswer].isSelected = true;
            setState(() {
              question.isSelected = true;
              widget.dataTopic.title = '';
              Utility.saveDataByName(widget.dataTopic);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: Utility.getColorInSelectBorder(
                        question, numAnswer, true))),
            color: Utility.getColorInSelect(question, numAnswer),
            child: Row(
              children: [
                Center(
                    child: Container(
                  width: 30,
                  margin: EdgeInsets.only(left: 10),
                  height: 30,
                  child: Center(
                      child: Text(
                    Utility.getTitleAnswer(numAnswer),
                    style: Utility.textStyleTitleAnswer,
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                )),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    title: Text(
                      question.answers[numAnswer].answerEn,
                      style: (question.isSelected &&
                              (question.answers[numAnswer].correct ||
                                  question.answers[numAnswer].isSelected))
                          ? Utility.textStyleAnswerEnWhite
                          : Utility.textStyleAnswerEn,
                    ),
                    subtitle: Text(
                      question.answers[numAnswer].answerVi,
                      style: (question.isSelected &&
                              (question.answers[numAnswer].correct ||
                                  question.answers[numAnswer].isSelected))
                          ? Utility.textStyleAnswerViWhite
                          : Utility.textStyleAnswerVi,
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (!question.isSelected) {
            question.answers[numAnswer].isSelected = true;
            setState(() {
              question.isSelected = true;
              widget.dataTopic.title = '';
              Utility.saveDataByName(widget.dataTopic);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: Utility.getColorInSelectBorder(
                        question, numAnswer, true))),
            color: Utility.getColorInSelect(question, numAnswer),
            child: Row(
              children: [
                Center(
                    child: Container(
                  width: 30,
                  margin: EdgeInsets.only(left: 10),
                  height: 30,
                  child: Center(
                      child: Text(
                    Utility.getTitleAnswer(numAnswer),
                    style: Utility.textStyleTitleAnswer,
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor.mainColor()),
                )),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 100,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    title: Text(
                      question.answers[numAnswer].answerEn,
                      style: (question.isSelected &&
                              (question.answers[numAnswer].correct ||
                                  question.answers[numAnswer].isSelected))
                          ? Utility.textStyleAnswerEnWhite
                          : Utility.textStyleAnswerEn,
                    ),
                    subtitle: Text(
                      question.answers[numAnswer].answerVi,
                      style: (question.isSelected &&
                              (question.answers[numAnswer].correct ||
                                  question.answers[numAnswer].isSelected))
                          ? Utility.textStyleAnswerViWhite
                          : Utility.textStyleAnswerVi,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                      child: Image(
                          image: AssetImage('images/imagecontent/' +
                              question.answers[numAnswer].answerCode),
                          fit: BoxFit.cover),
                    ),
                    flex: 2)
              ],
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
      );
    }
  }

  Row rowInQuestion(ListQuestion question, int index) {
    if (question.questionCode == null || question.questionCode!.isEmpty) {
      return Row(children: [
        Expanded(
          flex: 6,
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              title: Text(
                (index + 1).toString() + '. ' + question.questionEn,
                style: Utility.textStyleQuestionEn,
              ),
              subtitle: Text(
                question.questionVi,
                style: Utility.textStyleQuestionVi,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: FlatButton(
                onPressed: () {
                  if (widget.listCacheSave != null) {
                    if (widget.listCacheSave!.listQuestion == null) {
                      widget.listCacheSave!.listQuestion = <ListQuestion>[];
                    }

                    widget.listCacheSave!.listQuestion.remove(question);
                  }

                  Utility.saveDataCacheByTopicName(widget.listCacheSave!);
                  setState(() {

                  });
                },
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                )))
      ]);
    } else {
      return Row(children: [
        Expanded(
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              title: Text(
                (index + 1).toString() + '. ' + question.questionEn,
                style: Utility.textStyleQuestionEn,
              ),
              subtitle: Text(
                question.questionVi,
                style: Utility.textStyleQuestionVi,
              ),
            ),
          ),
          flex: 4,
        ),
        Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
              child: Image(
                  image: AssetImage(
                      'images/imagecontent/' + question.questionCode!),
                  fit: BoxFit.cover),
            ),
            flex: 3),
        Expanded(
            flex: 1,
            child: FlatButton(
                onPressed: () {
                  if (widget.listCacheSave != null) {
                    if (widget.listCacheSave!.listQuestion == null) {
                      widget.listCacheSave!.listQuestion = <ListQuestion>[];
                    }
                    widget.listCacheSave!.listQuestion.remove(question);
                  }
                  Utility.saveDataCacheByTopicName(widget.listCacheSave!);
                  setState(() {

                  });
                },
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                )))
      ]);
    }
  }

  void gotoReviewScreen(DataTopic data, int index) {
    var screen =
        ReviewQuestionScreen(data, index, _onTapButton, widget.listCacheSave);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  _onTapButton() {
    setState(() {});
  }

  Card buildCardItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      color: HexColor.mainColor(),
      elevation: 8.0,
      shadowColor: HexColor.getMultipleColorFromIndex(index),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        leading: CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 3.0,
          percent: numberCorrect(widget.dataTopic.data[index]) * 0.01,
          progressColor: HexColor.colorGreen(),
          center: new Text(
              numberCorrect(widget.dataTopic.data[index]).toString() + '%',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          widget.dataTopic.data[index].topic,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }

  int numberCorrect(Data data) {
    int numberSelected = 0;
    int numberCountCorrect = 0;
    for (ListQuestion item in data.listQuestion) {
      int count = 0;
      if (item.isSelected) {
        numberSelected += 1;
      }
      for (Answers answer in item.answers) {
        if (item.isSelected && (answer.isSelected && answer.correct)) {
          count += 1;
        }
      }
      if (count > 0) {
        numberCountCorrect += 1;
      }
    }
    if (numberSelected == 0) {
      return 0;
    }
    double percent =
        (numberCountCorrect.toDouble() / data.listQuestion.length) * 100;
    return percent.round();
  }
}
