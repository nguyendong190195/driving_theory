import 'package:driving_theory/extension/circular_percent_indicator.dart';
import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/utility.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab1/review_question_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PracticeAllQuestionScreen extends StatefulWidget {
  DataTopic dataTopic;

  PracticeAllQuestionScreen(this.dataTopic);

  @override
  State<StatefulWidget> createState() {
    return _PracticeAllQuestionState();
  }
}

class _PracticeAllQuestionState extends State<PracticeAllQuestionScreen> {
  bool hasRunViewDidAppearThisAppOpening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice all questions'),
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



  void gotoReviewScreen(DataTopic data, int index) {
    var screen = ReviewQuestionScreen(data, index, _onTapButton);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  _onTapButton() {
    setState(() {

    });
  }


  Card buildCardItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      color: Colors.white,
      elevation: 8.0,
      shadowColor: HexColor.getMultipleColorFromIndex(index),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          leading: CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 3.0,
            percent: numberCorrect(widget.dataTopic.data[index]) * 0.01,
            progressColor: HexColor.mainColor(),
            center: new Text(
                numberCorrect(widget.dataTopic.data[index]).toString() + '%',
                style: TextStyle(
                    color: HexColor.mainColor(), fontWeight: FontWeight.bold)),
          ),
          title: Text(
            widget.dataTopic.data[index].topic,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.arrow_forward),
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
