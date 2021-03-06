import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab2/review_mock_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:driving_theory/screens/tab1/review_question_screen.dart';

class StartedTestsScreen extends StatefulWidget {
  List<ListQuestion> questions = <ListQuestion>[];

  StartedTestsScreen(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _StartedTestsState();
  }
}

class _StartedTestsState extends State<StartedTestsScreen> {
  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  PageController pageController2 = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: widget.questions.length,
        child: Scaffold(
          appBar: AppBar(
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
            title: Text('Mock tests'),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  DataTopic datas = new DataTopic('title');
                  datas.data = <Data>[];
                  for(ListQuestion item in widget.questions) {
                    item.isSelected = true;
                  }
                  Data data = new Data('topic', widget.questions);
                  datas.data.add(data);
                  gotoReviewScreen(datas, 0);

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

  void gotoReviewScreen(DataTopic data, int index) {
    var screen = ReviewMockTestScreen(data, index, _onTapButton);
    Navigator.of(context).push(MaterialPageRoute(settings: RouteSettings(name: "/Page2"),builder: (context) => screen));
  }

  _onTapButton() {
  }

  Widget buildItemReview(int index) {
    ListQuestion question = widget.questions[index];
    return SingleChildScrollView(
      child: Container(
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
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
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
      },
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

  Future<bool> _onBackPressed() async {
    return true;
  }
}
