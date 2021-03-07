import 'dart:math';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab2/started_tests_screen.dart';
import 'package:flutter/material.dart';

class MockTestsScreen extends StatefulWidget {
  DataTopic dataTopic;
  late List<ListQuestion> datas = <ListQuestion>[];
  MockTestsScreen(this.dataTopic);

  @override
  State<StatefulWidget> createState() {
    for (Data data in dataTopic.data) {
      for (ListQuestion question in data.listQuestion) {
        datas.add(question.clone());
      }
    }
    return _MockTestsState();
  }
}

class _MockTestsState extends State<MockTestsScreen> {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'images/logo_app_2.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        fit: BoxFit.cover); //<- Creates a widget that displays an image.
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock tests', style: TextStyle(color: Colors.white)),
        backgroundColor: HexColor.mainColor(),
      ),
      body: Scaffold(
        backgroundColor: HexColor.colorGreen(),
        body: Container(
          decoration: BoxDecoration(color: HexColor.colorGreen()),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: ClipOval(
                      child: image,
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      color: HexColor.colorButton(),
                      minWidth: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        List<ListQuestion> dataRandom = <ListQuestion>[];
                        for (int i = 0; i < 50; i++) {
                          ListQuestion question =
                              widget.datas[new Random().nextInt(50)];
                          dataRandom.add(question);
                        }
                        var screen = StartedTestsScreen(widget.dataTopic.data[0].listQuestion);
                        Navigator.of(context).push(
                            MaterialPageRoute(settings: RouteSettings(name: "/Page1"),builder: (context) => screen));
                      },
                      child: Text(
                        "Start tests",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void gotoReviewScreen() {}
}
