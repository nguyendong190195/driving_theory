import 'dart:async';
import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/gallery_photo_view_wrapper.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab2/review_mock_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class StartedTestsScreen extends StatefulWidget {
  List<ListQuestion> questions = <ListQuestion>[];

  StartedTestsScreen(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _StartedTestsState();
  }
}

class _StartedTestsState extends State<StartedTestsScreen> {
   CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch +
      Duration(seconds: 3420).inMilliseconds;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
    controller.disposeTimer();
    DataTopic datas = new DataTopic('title');
    datas.data = <Data>[];
    for (ListQuestion item in widget.questions) {
      item.isSelected = true;
    }
    Data data = new Data('Result', widget.questions);
    datas.data.add(data);
    var screen = ReviewMockTestScreen(datas, 0, _onTapButton);
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "/Page2"), builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: widget.questions.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor.mainColor(),
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              unselectedLabelColor: Colors.white70,
              isScrollable: true,
              indicatorColor: Colors.green,
              tabs: widget.questions
                  .asMap()
                  .map((key, value) => MapEntry(
                      key,
                      Tab(
                          child: Text(
                        'Question ' + (key + 1).toString(),
                        textAlign: TextAlign.start,
                      ))))
                  .values
                  .toList(),
            ),
            title: CountdownTimer(
              widgetBuilder: (context, currentTime) {
                return Text(dateTimeColdown(currentTime));
              },
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              onEnd: onEnd,
              endTime: endTime,
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Are you sure you want to quit?"),
                            content: Text(
                                "All progress in this session will be lost"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text('Cancel')),
                              FlatButton(
                                  onPressed: () {
                                    onEnd();
                                  },
                                  child: Text('OK')),
                            ],
                          ));
                  // onEnd();
                },
                child: Text(
                  'Finish',
                  style: TextStyle(fontSize: 16),
                ),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: TabBarView(
            children: widget.questions
                .asMap()
                .map((key, value) =>
                    MapEntry(key, Container(child: buildItemReview(key))))
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  String dateTimeColdown(CurrentRemainingTime currentRemainingTime) {
    String time = '';
    if (currentRemainingTime.min != null) {
      if (currentRemainingTime.min < 10) {
        time = '0' + currentRemainingTime.min.toString();
      } else {
        time = currentRemainingTime.min.toString();
      }
    } else {
      time += '00';
    }

    if (currentRemainingTime.sec != null) {
      if (currentRemainingTime.sec < 10) {
        time += ':0' + currentRemainingTime.sec.toString();
      } else {
        time += ':' + currentRemainingTime.sec.toString();
      }
    }

    return time;
  }

  _onTapButton() {}

  Widget buildItemReview(int index) {
    ListQuestion question = widget.questions[index];
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
          for (Answers item in question.answers) {
            item.isSelected = false;
          }
          question.answers[numAnswer].isSelected = true;
          setState(() {});
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
          question.isSelected = true;
          for (Answers item in question.answers) {
            item.isSelected = false;
          }
          question.answers[numAnswer].isSelected = true;
          setState(() {});
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

  Future<bool> _onBackPressed() async {
    return true;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
