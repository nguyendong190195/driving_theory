
import 'dart:ui';

import 'package:driving_theory/extension/circular_percent_indicator.dart';
import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';

class ReviewMockTestScreen extends StatefulWidget {
  DataTopic dataTopic;
  int index;
  late final VoidCallback onTap;

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

        ),
        body: Container(
          child: (numberTotal() > 0 ? getColumnPercent() : getColumnNonePercent()),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  Column getColumnNonePercent () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 16,
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return buildItemReview(index);
                },
                itemCount: widget.dataTopic.data[widget.index].listQuestion.length,
              )),
        ),
      ],
    );
  }
  Column getColumnPercent () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Row(
              children: [
                Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 3.0,
                              percent: numberCorrect() * 0.01,
                              progressColor: Colors.green,
                              center: new Text(numberCorrect().toString() + '%',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text('Correct'))
                        ],
                      ),
                    )),
              ],
            ),
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
                itemCount: widget.dataTopic.data[widget.index].listQuestion.length,
              )),
        ),
      ],
    );
  }

  int numberTotal() {
    int number = 0;
    for (ListQuestion item in widget.dataTopic.data[widget.index].listQuestion) {
      if (item.isSelected) {
        number += 1;
      }
    }
    double percent =
        (number.toDouble() / widget.dataTopic.data[widget.index].listQuestion.length.toDouble()) * 100;
    percent.round();
    return percent.round();
  }

  int numberCorrect() {
    int numberSelected = 0;
    int numberCountCorrect = 0;
    for (ListQuestion item in widget.dataTopic.data[widget.index].listQuestion) {
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
        (numberCountCorrect.toDouble() / widget.dataTopic.data[widget.index].listQuestion.length) * 100;
    return percent.round();
  }

  Widget buildItemReview(int index) {
    ListQuestion question = widget.dataTopic.data[widget.index].listQuestion[index];
    return Container(
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
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
            getItemAnswer(question, 0),
            getItemAnswer(question, 1),
            getItemAnswer(question, 2),
            getItemAnswer(question, 3),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
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
    return GestureDetector(
      onTap: () {
        if (!question.isSelected) {
          question.answers[numAnswer].isSelected = true;
          setState(() {
            question.isSelected = true;
          });
        }
      }   ,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: Utility.getColorInSelectBorder(
                        question, numAnswer, true))),
            color: Utility.getColorInSelect(question, numAnswer),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                      child: Container(
                        width: 30,
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
                  flex: 2,
                ),
                Expanded(
                  flex: 15,
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
      ),
    );
  }
}
