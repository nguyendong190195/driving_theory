import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';

class MockTestsScreen extends StatefulWidget {
  List<Data> datas;
  MockTestsScreen(this.datas);
  @override
  State<StatefulWidget> createState() {
    return _MockTestsState();
  }

}

class _MockTestsState extends State<MockTestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello 2'),
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}