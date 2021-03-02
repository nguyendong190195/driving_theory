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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.topic),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            ListQuestion question = widget.data.listQuestion[index];
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    title: Text(question.questionEn),
                    subtitle: Text(question.questionVi),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          title: Text(question.answers[0].answerEn),
                          subtitle: Text(question.answers[0].answerVi),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          title: Text(question.answers[1].answerEn),
                          subtitle: Text(question.answers[1].answerVi),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          title: Text(question.answers[2].answerEn),
                          subtitle: Text(question.answers[2].answerVi),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          title: Text(question.answers[3].answerEn),
                          subtitle: Text(question.answers[3].answerVi),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: widget.data.listQuestion.length,
        ),
      ),
    );
  }
}
