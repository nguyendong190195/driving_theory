import 'dart:ui';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/gallery_photo_view_wrapper.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';

class ReviewMockTestScreen extends StatefulWidget {
  DataTopic dataTopic;
  int index;
   final VoidCallback onTap;

  ReviewMockTestScreen(this.dataTopic, this.index, this.onTap);

  @override
  State<StatefulWidget> createState() {
    return _ReviewMockTestState();
  }
}

class _ReviewMockTestState extends State<ReviewMockTestScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.dataTopic.data[widget.index].topic),
          backgroundColor: HexColor.mainColor(),
        ),
        body: Container(
          child: getColumnPercent(),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  Column getColumnPercent() {
    var assetsImage = new AssetImage(
        'images/background_result.jpeg');
    var image = new Image(
        image: assetsImage,
        fit: BoxFit.cover);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: assetsImage,
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                    child: Text(
                  'Your achieve',
                  style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                    child: Text(percentTotal().toString() + '%',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                    child: Text(
                        'You has answered ' +
                            numberCorrect().toString() +
                            ' out of 50 questions correctly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 8),
                child: Center(
                    child: Text(numberCorrect() > 43 ? 'PASS' : 'FAIL',
                        style: TextStyle(
                            fontSize: 27.0,
                            color: numberCorrect() > 43 ? Colors.green : Colors.redAccent,
                            fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 16,
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return buildItemReview(index);
                },
                itemCount:
                    widget.dataTopic.data[widget.index].listQuestion.length,
              )),
        ),
      ],
    );
  }

  int numberTotal() {
    int number = 0;
    for (ListQuestion item
        in widget.dataTopic.data[widget.index].listQuestion) {
      if (item.isSelected) {
        number += 1;
      }
    }
    double percent = (number.toDouble() /
            widget.dataTopic.data[widget.index].listQuestion.length
                .toDouble()) *
        100;
    percent.round();
    return percent.round();
  }

  int percentTotal() {
    double percent = numberCorrect().toDouble() / 50.toDouble();
    return (percent * 100).round();
  }

  int numberCorrect() {
    int numberSelected = 0;
    int numberCountCorrect = 0;
    for (ListQuestion item
        in widget.dataTopic.data[widget.index].listQuestion) {
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

    return numberCountCorrect;
  }

  Widget buildItemReview(int index) {
    ListQuestion question =
    widget.dataTopic.data[widget.index].listQuestion[index];
    if (question.questionCode == null || question.questionCode.isEmpty) {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                  title: Text(
                    (index + 1).toString() + '. ' + question.questionEn,
                    style: Utility.textStyleQuestionEn,
                  ),
                ),
              ),
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
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                      title: Text(
                        (index + 1).toString() + '. ' + question.questionEn,
                        style: Utility.textStyleQuestionEn,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Utility.open(context, GalleryExampleItem(
                          id: "tag1",
                          resource: 'images/imagecontent/' + question.questionCode.trim(),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                        child: Image(
                            image: AssetImage(
                                'images/imagecontent/' + question.questionCode.trim()),
                            fit: BoxFit.cover),
                      ),
                    ),
                    flex: 2)
              ]),
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
          ),
        ),
      );
    }
  }



  Widget getItemAnswer(ListQuestion question, int numAnswer) {
    if (question.answers[numAnswer].answerCode == null ||
        question.answers[numAnswer].answerCode.isEmpty) {
      return GestureDetector(
        onTap: () {

        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: question.answers[numAnswer].isSelected
                        ? HexColor.colorAnswerCorrect()
                        : HexColor.colorAnswerNormal())),
            color: question.answers[numAnswer].isSelected
                ? HexColor.colorAnswerCorrect()
                : HexColor.colorAnswerNormal(),
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
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Utility.open(context, GalleryExampleItem(
                          id: "tag1",
                          resource: 'images/imagecontent/' + question.answers[numAnswer].answerCode.trim(),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                        child: Image(
                            image: AssetImage('images/imagecontent/' +
                                question.answers[numAnswer].answerCode.trim()),
                            fit: BoxFit.cover),
                      ),
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
}
