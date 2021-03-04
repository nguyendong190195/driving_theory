import 'dart:ui';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';

class ReviewQuestionScreen extends StatefulWidget {
  Data data;

  ReviewQuestionScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    return _ReviewQuestionState();
  }
}

class _ReviewQuestionState extends State<ReviewQuestionScreen> {
  late TextStyle textStyleQuestionEn;
  late TextStyle textStyleQuestionVi;
  late TextStyle textStyleAnswerEn;
  late TextStyle textStyleAnswerVi;
  late TextStyle textStyleTitleAnswer;

  @override
  Widget build(BuildContext context) {
    textStyleQuestionEn =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
    textStyleQuestionVi = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        fontStyle: FontStyle.italic);
    textStyleAnswerEn =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,);
    textStyleAnswerVi = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
        fontStyle: FontStyle.italic);

    textStyleTitleAnswer = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
    color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.topic),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {},
            child: Text("Reset"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return buildItemReview(index);
          },
          itemCount: widget.data.listQuestion.length,
        ),
      ),
    );
  }

  Widget buildItemReview(int index) {
    ListQuestion question = widget.data.listQuestion[index];
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
                question.questionEn,
                style: textStyleQuestionEn,
              ),
              subtitle: Text(
                question.questionVi,
                style: textStyleQuestionVi,
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
          question.answers[numAnswer].isSelected = true;
          setState(() {

          });
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: question.answers[numAnswer].isSelected ? HexColor.colorAnswerCorrect() : HexColor.colorAnswerNormal(),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Center(child: Text(Utility.getTitleAnswer(numAnswer), style: textStyleTitleAnswer,)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red
                          ),
                        )
                    ),
                flex: 2,),
                Expanded(
                  flex: 15,
                    child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  title: Text(
                    question.answers[numAnswer].answerEn,
                    style: textStyleAnswerEn,
                  ),
                  subtitle: Text(
                    question.answers[numAnswer].answerVi,
                    style: textStyleAnswerVi,
                  ),
                ))
              ],
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
      ),
    );
  }
}
