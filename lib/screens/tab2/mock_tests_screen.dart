import 'dart:convert';
import 'dart:math';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:driving_theory/screens/tab2/started_tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MockTestsScreen extends StatefulWidget {
  DataTopic dataTopic;
   List<ListQuestion> datas = <ListQuestion>[];
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
        'images/ic_logo_app.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        fit: BoxFit.cover); //<- Creates a widget that displays an image.
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock tests', style: TextStyle(color: Colors.white)),
        backgroundColor: HexColor.mainColor(),
      ),
      body: Scaffold(
        backgroundColor: HexColor.colorBackGround(),
        body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('key'),
          builder: (context, snapshot) {
            var new_data = json.decode(snapshot.data.toString());
            if (new_data != null) {
              widget.dataTopic = DataTopic.fromJson(new_data);
            }

            return Container(
              decoration: BoxDecoration(color: HexColor.colorBackGround()),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height: 300,
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
                            for (Data data in widget.dataTopic.data) {
                              for (ListQuestion question in data.listQuestion) {
                                widget.datas.add(question.clone());
                              }
                            }
                            List<ListQuestion> dataRandom = <ListQuestion>[];
                            Set<int> indexSet = new Set();
                            while(true) {
                              indexSet.add(new Random().nextInt(widget.datas.length));
                              if (indexSet.length == 50) {
                                break;
                              }
                            }
                            for (int i = 0; i < indexSet.length; i++) {
                              ListQuestion question =
                                widget.datas[indexSet.elementAt(i)];
                              dataRandom.add(question.clone());
                            }

                            var screen = StartedTestsScreen(dataRandom);
                            Navigator.of(context).push(
                                MaterialPageRoute(settings: RouteSettings(name: "/Page1"),builder: (context) => screen));
                          },
                          child: Text(
                            "Start example test now",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String> getJson() {
    return rootBundle.loadString('json_data.json');
  }

}
