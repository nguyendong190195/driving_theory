import 'package:driving_theory/extension/circular_percent_indicator.dart';
import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab1/review_question_screen.dart';
import 'package:flutter/material.dart';

class PracticeAllQuestionScreen extends StatefulWidget {
  List<Data> data;
  PracticeAllQuestionScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    return _PracticeAllQuestionState();
  }

}

class _PracticeAllQuestionState extends State<PracticeAllQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice all questions'),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Data data = widget.data[index];
              var screen = ReviewQuestionScreen(data.clone());
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => screen));
            },
            child: buildCardItem(index),
          );
        },
        itemCount: widget.data.length,),
      ),
    );
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
            percent: 0.7,
            progressColor: HexColor.mainColor(),
            center: new Text("70%", style: TextStyle(color: HexColor.mainColor(), fontWeight: FontWeight.bold)),
          ),
          title: Text(widget.data[index].topic, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}