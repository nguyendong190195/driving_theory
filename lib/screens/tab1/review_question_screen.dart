import 'dart:ui';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/gallery_photo_view_wrapper.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReviewQuestionScreen extends StatefulWidget {
  DataTopic dataTopic;
  int index;
   final VoidCallback onTap;
  Data listCacheSave;

  ReviewQuestionScreen(
      this.dataTopic, this.index, this.onTap, this.listCacheSave);

  @override
  State<StatefulWidget> createState() {
    return _ReviewQuestionState();
  }
}

class _ReviewQuestionState extends State<ReviewQuestionScreen> {
  bool verticalGallery = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor.mainColor(),
          title: Text(widget.dataTopic.data[widget.index].topic),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                for (ListQuestion item
                    in widget.dataTopic.data[widget.index].listQuestion) {
                  item.isSelected = false;
                  for (Answers answer in item.answers) {
                    answer.isSelected = false;
                  }
                }
                setState(() {
                  widget.dataTopic.title = '';
                  Utility.saveDataByName(widget.dataTopic);
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 16),
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Container(
          child:
              (numberTotal() > 0 ? getColumnPercent() : getColumnNonePercent()),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.onTap();
    return true;
  }

  Column getColumnNonePercent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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

  Column getColumnPercent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 3.0,
                        percent: numberTotal() * 0.01,
                        progressColor: HexColor.mainColor(),
                        center: new Text(numberTotal().toString() + '%',
                            style: TextStyle(
                                color: HexColor.mainColor(),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      margin: EdgeInsets.only(left: 10),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10), child: Text('Total'))
                  ],
                ),
              ),
              Container(
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
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
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
    double percent = (numberCountCorrect.toDouble() /
            widget.dataTopic.data[widget.index].listQuestion.length) *
        100;
    return percent.round();
  }

  Widget buildItemReview(int index) {
    ListQuestion question =
        widget.dataTopic.data[widget.index].listQuestion[index];
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
        ),
        margin: EdgeInsets.only(bottom: 15),
      ),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.grey[400],
            blurRadius: 1.0,
          ),
        ],
      ),
    );
  }

  Row rowInQuestion(ListQuestion question, int index) {
    if (question.questionCode == null || question.questionCode.isEmpty) {
      if (widget.listCacheSave != null &&
          widget.listCacheSave.listQuestion.contains(question)) {
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
        ]);
      } else {
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
                      if (widget.listCacheSave.listQuestion == null) {
                        widget.listCacheSave.listQuestion = <ListQuestion>[];
                      }
                      widget.listCacheSave.listQuestion.add(question);
                    } else {
                      widget.listCacheSave = Data('', <ListQuestion>[]);
                      widget.listCacheSave.listQuestion.add(question);
                    }
                    Utility.saveDataCacheByTopicName(widget.listCacheSave);
                    setState(() {});
                  },
                  child: Icon(
                    Icons.save,
                  )))
        ]);
      }
    } else {
      if (widget.listCacheSave != null &&
          widget.listCacheSave.listQuestion.contains(question)) {
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
              child: GestureDetector(
                onTap: (){
                  open(context, GalleryExampleItem(
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
              flex: 3),
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
              child: GestureDetector(
                onTap: (){
                  open(context, GalleryExampleItem(
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
              flex: 3),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    if (widget.listCacheSave != null) {
                      if (widget.listCacheSave.listQuestion == null) {
                        widget.listCacheSave.listQuestion = <ListQuestion>[];
                      }
                      widget.listCacheSave.listQuestion.add(question);
                    } else {
                      widget.listCacheSave = Data('', <ListQuestion>[]);
                      widget.listCacheSave.listQuestion.add(question);
                    }
                    Utility.saveDataCacheByTopicName(widget.listCacheSave);

                    setState(() {});
                  },
                  child: Icon(
                    Icons.save,
                  )))
        ]);
      }
    }
  }

  void open(BuildContext context, GalleryExampleItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: [item],
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: 0,
          scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
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
                    child: GestureDetector(
                      onTap: (){
                        open(context, GalleryExampleItem(
                          id: "tag1",
                          resource: 'images/imagecontent/' + question.answers[numAnswer].answerCode.trim(),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                        child: Image(
                            image: AssetImage('images/imagecontent/' +
                                question.answers[numAnswer].answerCode),
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
